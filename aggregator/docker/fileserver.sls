#!yaml|gpg
docker:
  containers:
    nodewatcher-fileserver:
      image: wlanslovenija/scp-server
      environment:
        # This password does not need to be encrypted as it is public information.
        - FILESERVER_PASSWORD: LVAjxOKzouvbbUoW9WPt
      network_mode:
        type: container
        container: mesh-network
      volumes:
        /srv/storage/nodewatcher/media:
          type: other
          bind: /readonly/files
          readonly: true
