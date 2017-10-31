docker:
  containers:
    redis:
      image: tozd/redis
      network_mode:
        name: nodewatcher
      volumes:
        /srv/log/redis:
          bind: /var/log/redis
          user: nobody
          group: nogroup
