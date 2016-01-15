docker:
  containers:
    redis:
      image: tozd/redis
      volumes:
        /srv/log/redis:
          bind: /var/log/redis
          user: nobody
          group: nogroup
