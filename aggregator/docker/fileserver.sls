#!yaml|gpg
docker:
  containers:
    nodewatcher-fileserver:
      image: wlanslovenija/scp-server
      environment:
        - FILESERVER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1M6TGKaUX9k6B/NJPwpJlKaTEu9LBaEiMVLz+9NaKituc8IB9Ynm/r07rRq65AXSu+bHBO9431TPiRRQ3oak7nlXhIWTUL2oH4DnwFbmFm5/NkFdP9p+PYcn9YnhmWGAGFFdKGDuiGHcbVH/bulvZobBC2EDvDOlg1iA2/Xx9Jdgyq8t6M0iIxaEQydGxNa/2JpfRu4O9uHq3+LZjM6i4/X2IY9JYFPUUMhnZ80uHBrjWHXZgBEyF9aT01PXvGejxJ5D4UDVe2UT6Tbl1/w/zEq9BnNt1ZggXUz7S/h2xrlZMrVMDDEnBE2Mbq1tHXyHeEoclLMG9RIpF/osG1Ja3 nodeupgrade@wlan-si.net
      network_mode:
        type: container
        container: mesh-network
      volumes:
        /srv/storage/nodewatcher/fileserver-keys:
          bind: /etc/ssh/keys
          mode: 700
        /srv/storage/nodewatcher/media:
          type: other
          bind: /readonly/files
          readonly: true
