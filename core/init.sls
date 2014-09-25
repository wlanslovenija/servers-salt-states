en_US.UTF-8:
  locale.system

kernel.panic:
  sysctl.present:
    - value: 10

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

net.ipv6.conf.all.forwarding:
  sysctl.present:
    - value: 1

net.ipv6.conf.default.forwarding:
  sysctl.present:
    - value: 1

net.ipv4.conf.all.send_redirects:
  sysctl.present:
    - value: 0

net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value: 0

net.ipv4.conf.default.send_redirects:
  sysctl.present:
    - value: 0

net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value: 0

sysfsutils:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: sysfsutils
