python-ipaddr:
  pkg.installed

netcfg:
  pip.installed:
    - name: netcfg==0.1.0
    - require:
      - pkg: python-ipaddr
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
