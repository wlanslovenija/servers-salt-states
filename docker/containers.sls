# Setup docker containers
{% set kernel_modules = [] %}
{% set networks = [] %}
{% set sysctls = dict() %}
{% for container, cfg in pillar['docker']['containers'].items() %}
{{ container }}-image:
  docker.pulled:
    - name: {{ cfg['image'] }}

{{ container }}-installed:
  docker.installed:
    - name: {{ container }}
    - hostname: {{ container }}
    - image: {{ cfg['image'] }}
{% if cfg.get('environment') %}
    - environment:
{% for key, value in cfg['environment'].items() %}
      - {{ key }}: {{ value }}
{% endfor %}
{% endif %}
    - require:
      - docker: {{ container }}-image
{% do sysctls.update(cfg.get('sysctl', {})) %}
{% for sysctl in cfg.get('sysctl', {}).keys() %}
      - sysctl: {{ sysctl }}
{% endfor %}
{% for module in cfg.get('host_kernel_modules', []) %}
{% if module not in kernel_modules %}{% do kernel_modules.append(module) %}{% endif %}
      - kmod: docker-kmod-{{ module }}
{% endfor %}

{{ container }}-container:
  docker.running:
    - container: {{ container }}
{% if cfg.get('capabilities', []) %}
    - cap_add:
{% for cap in cfg['capabilities'] %}
      - {{ cap }}
{% endfor %}
{% endif %}
    - require:
      - docker: {{ container }}-installed

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

# Setup required networks on the host
{% for net in networks %}
network-{{ net }}:
  cmd.run:
    - name: netcfg create {{ net }} bridge
    - require:
      - sls: docker.network
{% endfor %}
