#!yaml|gpg
docker:
  containers:
    rocket-chat:
      image: rocketchat/rocket.chat
      network_mode:
        name: nodewatcher
      environment:
        - VIRTUAL_HOST: chat.wlan-si.net
          VIRTUAL_URL: /
          VIRTUAL_LETSENCRYPT: "true"
          MONGO_URL: mongodb://rocket-chat-db/rocketchat
          MONGO_OPLOG_URL: mongodb://rocket-chat-db/local
          ROOT_URL: https://chat.wlan-si.net
          MAIL_URL: smtp://mail.tnode.com/
    rocket-chat-db:
      image: mongo
      tag: 3.4
      network_mode:
        name: nodewatcher
      command: --smallfiles --oplogSize 128 --replSet rs0
      volumes:
        /srv/storage/rocket-chat:
          bind: /data/db
          user: 999
          group: root
