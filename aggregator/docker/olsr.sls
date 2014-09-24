docker:
  containers:
    olsrd:
      image: wlanslovenija/router-olsrd
      capabilities:
        - NET_ADMIN
      environment:
        ROUTER_MAIN_IP: 10.254.0.8
        ROUTER_INTERFACES: td-vpn0 td-vpn1
      networks:
        - id: td-vpn0
          ips:
            - address: 10.254.0.8/16
        - id: td-vpn1
          ips:
            - address: 10.254.0.6/16
