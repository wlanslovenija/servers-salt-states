python-ipaddr:
  pkg.installed

python-dev:
  pkg.installed

pkg-config:
  pkg.installed

build-essential:
  pkg.installed

libzmq3:
  pkg.installed

libzmq3-dev:
  pkg.installed

netcfg:
  pip.installed:
    - name: netcfg==0.1.0
    - require:
      - pkg: python-ipaddr
      - pkg: python-dev
      - pkg: pkg-config
      - pkg: build-essential
      - pkg: libzmq3
      - pkg: libzmq3-dev
      - sls: pip

/etc/init/netcfg.conf:
  file.managed:
    - source: salt://docker/netcfg.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pip: netcfg

netcfg-service:
  service.running:
    - name: netcfg
    - watch:
      - service: docker
      - file: /etc/init/netcfg.conf
      - pip: netcfg
