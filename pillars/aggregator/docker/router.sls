docker:
  containers:
    # Create a container that will hold the actual network resources for interacting with
    # the mesh network. This way, multiple other containers can share this network which
    # will not get lost even if the individual containers are taken down.
    mesh-network:
      image: kubernetes/pause
      networks:
        - id: td-vpn0
          ips:
            - address: 10.254.0.8/16
        - id: td-vpn1
          ips:
            - address: 10.254.0.6/16
        - id: td-vpn2
          ips:
            - address: 10.254.0.9/16
    # OLSR routing protocol.
    olsrd:
      image: wlanslovenija/router-olsrd
      capabilities:
        - NET_ADMIN
      environment:
        ROUTER_MAIN_IP: 10.254.0.8
        ROUTER_INTERFACES: td-vpn0 td-vpn1
      network_mode:
        type: container
        container: mesh-network
    # Babel routing protocol.
    babeld:
      image: wlanslovenija/router-babeld
      # Privileges needed because Docker does otherwise not allow setting network sysctls.
      # See: https://github.com/docker/docker/issues/4717#issuecomment-98653017
      privileged: true
      # TODO: The below capability drop does not really work for privileged containers.
      capabilities:
        # Drop all capabilities as the container is in privileged mode.
        - name: ALL
          drop: true
        # Only allow a small subset of capabilities.
        - NET_ADMIN
      environment:
        ROUTER_INTERFACES: td-vpn0 td-vpn1 td-vpn2
        BABELD_DISABLE_ANNOUNCE: 1
      network_mode:
        type: container
        container: mesh-network
