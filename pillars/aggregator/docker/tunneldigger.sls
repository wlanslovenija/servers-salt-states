docker:
  containers:
    tunneldigger-vpn0:
      image: wlanslovenija/tunneldigger-client
      host_kernel_modules:
        - l2tp_core
        - l2tp_eth
        - l2tp_netlink
      capabilities:
        - NET_ADMIN
      environment:
        TUNNELDIGGER_UUID: 5dcf6dae-9246-47ec-8ba5-f864d8f88778
        TUNNELDIGGER_BROKERS: 46.54.226.43:8942
        TUNNELDIGGER_BRIDGE: td-vpn0
      networks:
        - id: td-vpn0
      volumes:
        /srv/log/tunneldigger/vpn0:
          bind: /var/log/tunneldigger
          user: nobody
          group: nogroup
    tunneldigger-vpn1:
      image: wlanslovenija/tunneldigger-client
      host_kernel_modules:
        - l2tp_core
        - l2tp_eth
        - l2tp_netlink
      capabilities:
        - NET_ADMIN
      environment:
        TUNNELDIGGER_UUID: 5dcf6dae-9246-47ec-8ba5-f864d8f88778
        TUNNELDIGGER_BROKERS: 92.53.140.74:8942
        TUNNELDIGGER_BRIDGE: td-vpn1
      networks:
        - id: td-vpn1
      volumes:
        /srv/log/tunneldigger/vpn1:
          bind: /var/log/tunneldigger
          user: nobody
          group: nogroup
    tunneldigger-vpn2:
      image: wlanslovenija/tunneldigger-client
      host_kernel_modules:
        - l2tp_core
        - l2tp_eth
        - l2tp_netlink
      capabilities:
        - NET_ADMIN
      environment:
        TUNNELDIGGER_UUID: 5dcf6dae-9246-47ec-8ba5-f864d8f88778
        TUNNELDIGGER_BROKERS: 77.234.148.154:8942
        TUNNELDIGGER_BRIDGE: td-vpn2
      networks:
        - id: td-vpn2
      volumes:
        /srv/log/tunneldigger/vpn2:
          bind: /var/log/tunneldigger
          user: nobody
          group: nogroup
