{% set kernel_modules = [] %}
{% set networks = [] %}
{% set sysctls = dict() %}
{% set sysfs = dict() %}
{% set volumes = dict() %}

# Setup docker containers
{% for container, cfg in pillar['docker']['containers'].items() %}
{{ container }}-image:
  docker.pulled:
    - name: {{ cfg['image'] }}
    - require:
      - sls: docker.base

{{ container }}-container:
  docker.running:
    - name: {{ container }}
    - hostname: {{ container }}
    - image: {{ cfg['image'] }}
{% if cfg.get('environment') %}
    - environment:
{% for key, value in cfg['environment'].items() %}
      - {{ key }}: {{ value }}
{% endfor %}
{% endif %}
{% if cfg.get('capabilities', []) %}
    - cap_add:
{% for cap in cfg['capabilities'] %}
      - {{ cap }}
{% endfor %}
{% endif %}
    - require:
      - docker: {{ container }}-image
{% for volume in cfg.get('volumes', {}).keys() %}
      - file: {{ volume }}
{% endfor %}
{% do sysctls.update(cfg.get('sysctl', {})) %}
{% for sysctl in cfg.get('sysctl', {}).keys() %}
      - sysctl: {{ sysctl }}
{% endfor %}
{% do sysfs.update(cfg.get('sysfs', {})) %}
{% for sysfs in cfg.get('sysfs', {}).keys() %}
      - file: sysfs-{{ sysfs }}
{% endfor %}
{% for module in cfg.get('host_kernel_modules', []) %}
{% if module not in kernel_modules %}{% do kernel_modules.append(module) %}{% endif %}
      - kmod: docker-kmod-{{ module }}
{% endfor %}
{% if cfg.get('volumes', {}) %}
{% do volumes.update(cfg.get('volumes', {})) %}
    - volumes:
{% for volume, vol_cfg in cfg.get('volumes', {}).items() %}
      - {{ volume }}: {{ vol_cfg['bind'] }}
{% endfor %}
{% endif %}

{% macro format_addresses(net) %}
{% for ip_cfg in net.get('ips', []) %}--address {{ ip_cfg['address'] }} {% endfor %}
{% endmacro %}

{% for net in cfg.get('networks', []) %}
{% if net['id'] not in networks %}{% do networks.append(net['id']) %}{% endif %}
{{ container }}-network-{{ net['id'] }}:
  cmd.run:
    - name: netcfg attach {{ container }} {{ net['id'] }} {{ format_addresses(net) }}
    - require:
      - sls: docker.network
      - docker: {{ container }}-container
      - cmd: network-{{ net['id'] }}
{% endfor %}
{% endfor %}

# Setup required kernel modules on the host
{% for module in kernel_modules %}
docker-kmod-{{ module }}:
  kmod.present:
    - name: {{ module }}
    - persist: True
{% endfor %}

# Setup required sysctls on the host
{% for sysctl, value in sysctls.items() %}
{{ sysctl }}:
  sysctl.present:
    - value: {{ value }}
{% endfor %}

# Setup required sysfs configuration on the host
{% for sysfs, value in sysfs.items() %}
sysfs-{{ sysfs }}:
  file.managed:
    - name: /etc/sysfs.d/{{ sysfs }}.conf
    - contents: {{ sysfs|replace('.', '/') }} = {{ value }}
    - watch_in:
      - service: sysfsutils
{% endfor %}

# Setup required networks on the host
{% for net in networks %}
network-{{ net }}:
  cmd.run:
    - name: netcfg create {{ net }} bridge
    - require:
      - sls: docker.network
{% endfor %}

# Setup required volumes on the host
{% for volume, vol_cfg in volumes.items() %}
{{ volume }}:
  file.directory:
    - user: {{ vol_cfg.get('user', 'root') }}
    - group: {{ vol_cfg.get('group', 'root') }}
    - mode: 755
    - makedirs: True
{% endfor %}
