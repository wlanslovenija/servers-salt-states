python-ipaddr:
  pkg.installed

python-dev:
  pkg.installed

pkg-config:
  pkg.installed

build-essential:
  pkg.installed

{% if grains['oscodename'] == 'xenial' %}
libzmq5:
  pkg.installed

libzmq5-dev:
  pkg.installed
{% elif grains['oscodename'] == 'trusty' %}
libzmq3:
  pkg.installed

libzmq3-dev:
  pkg.installed
{% endif %}

netcfg:
  pip.installed:
    - name: netcfg==0.1.0
    - require:
      - pkg: python-ipaddr
      - pkg: python-dev
      - pkg: pkg-config
      - pkg: build-essential
      {% if grains['oscodename'] == 'xenial' %}
      - pkg: libzmq5
      - pkg: libzmq5-dev
      {% elif grains['oscodename'] == 'trusty' %}
      - pkg: libzmq3
      - pkg: libzmq3-dev
      {% endif %}
      - sls: pip

{% if grains['oscodename'] == 'xenial' %}
/etc/systemd/system/netcfg.service:
  file.managed:
    - source: salt://docker/netcfg.service
    - user: root
    - group: root
    - mode: 644
    - require:
      - pip: netcfg
{% elif grains['oscodename'] == 'trusty' %}
/etc/init/netcfg.conf:
  file.managed:
    - source: salt://docker/netcfg.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pip: netcfg
{% endif %}

netcfg-service:
  service.running:
    - name: netcfg
    - watch:
      - service: docker
      {% if grains['oscodename'] == 'xenial' %}
      - file: /etc/systemd/system/netcfg.service
      {% elif grains['oscodename'] == 'trusty' %}
      - file: /etc/init/netcfg.conf
      {% endif %}
      - pip: netcfg
