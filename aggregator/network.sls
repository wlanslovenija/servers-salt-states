network:
  system:
    hostname: aggregator
    fqdn: aggregator.wlan-si.net
  dns:
    - 2001:4860:4860::8844
    - 2001:4860:4860::8888
    - 8.8.8.8
  interfaces:
    p3p1:
      ipv4:
        - type: static
          address: 212.101.139.12
          netmask: 255.255.255.0
          gateway: 212.101.139.1
      ipv6:
        - type: static
          address: 2a00:1368:1000:30::12
          netmask: 64
          gateway: 2a00:1368:1000:30::1
mailer:
    relay: mail.tnode.com
    root_alias:
      - monitoring@unico.re
      - mitar.aggregator@tnode.com
