#!pyobjects

import os
from salt.utils import pyobjects

Sls = pyobjects.StateFactory('sls')

def state(_cls, _func, _id, **kwargs):
    from salt.utils import pyobjects

    try:
        return getattr(_cls, _func)(_id, **kwargs).requisite
    except pyobjects.DuplicateState:
        return _cls(_id)

# Setup docker containers
for container, cfg in pillar('docker:containers').items():
    docker_image = state(
        Docker, 'pulled',
        '%s-image' % container,
        name=cfg['image'],
        require=Sls('docker.base'),
    )

    requires = [docker_image]
    volumes = [{volume: vol_cfg['bind']} for volume, vol_cfg in cfg.get('volumes', {}).items()]

    # Create the required configs
    for cfg_name, cfg_path in cfg.get('config', {}).items():
        contents = pillar('docker:configs:%s' % cfg_name)
        if contents:
            cfg_host_path = os.path.join('/srv/storage/config', cfg_name)
            volume = state(
                File, 'managed',
                cfg_host_path,
                contents=contents,
                user='root',
                group='root',
                mode=644,
                makedirs=True,
            )
            volumes.append({cfg_host_path: cfg_path})
            requires.append(volume)

    # Create the required volumes
    for vol_name, vol_cfg in cfg.get('volumes', {}).items():
        volume = state(
            File, 'directory',
            vol_name,
            user=vol_cfg.get('user', 'root'),
            group=vol_cfg.get('group', 'root'),
            mode=755,
            makedirs=True,
        )
        requires.append(volume)

    # Setup required kernel modules on the host
    for module_name in cfg.get('host_kernel_modules', []):
        module = state(
            Kmod, 'present',
            module_name,
            name=module_name,
            persist=True,
        )
        requires.append(module)

    # Setup required sysctls on the host
    for sysctl_name, sysctl_value in cfg.get('sysctl', {}).items():
        sysctl = state(
            Sysctl, 'present',
            sysctl_name,
            value=sysctl_value,
        )
        requires.append(sysctl)

    # Setup required sysfs configuration on the host
    for sysfs_name, sysfs_value in cfg.get('sysfs', {}).items():
        sysfs = state(
            File, 'managed',
            sysfs_name,
            name='/etc/sysfs.d/%s.conf' % sysfs_name,
            contents='%s = %s' % (sysfs_name.replace('.', '/'), sysfs_value),
            watch_in=Service('sysfsutils'),
        )
        requires.append(sysfs)

    # Setup required links
    links = {}
    for link_name, link_alias in cfg.get('links', {}).items():
        requires.append(Docker('%s-container' % link_name))
        links[link_name] = link_alias

    docker_container = state(
        Docker, 'running',
        '%s-container' % container,
        name=container,
        hostname=container,
        image=cfg['image'],
        environment=[{key: value} for key, value in cfg.get('environment', {}).items()],
        cap_add=cfg.get('capabilities', []),
        volumes=volumes,
        links=links,
        require=requires,
    )

    # Setup required networks on the host
    for net_cfg in cfg.get('networks', []):
        net_create = state(
            Cmd, 'run',
            'network-%s' % net_cfg['id'],
            name='netcfg create %s bridge' % net_cfg['id'],
            require=Sls('docker.network'),
        )

        net_attach = state(
            Cmd, 'run',
            '%s-network-%s' % (container, net_cfg['id']),
            name='netcfg attach %s %s %s' % (
                container,
                net_cfg['id'],
                " ".join(['--address %s' % ip_cfg['address'] for ip_cfg in net_cfg.get('ips', [])]),
            ),
            require=[
                Sls('docker.network'),
                net_create,
                docker_container,
            ],
        )
