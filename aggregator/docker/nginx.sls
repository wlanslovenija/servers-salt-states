docker:
  containers:
    nginx-proxy:
      image: tozd/nginx-proxy
      ports:
        80/tcp:
          ip: 212.101.139.12
          port: 80
        443/tcp:
          ip: 212.101.139.12
          port: 443
      volumes:
        /srv/storage/ssl:
          bind: /ssl
          user: root
          group: root
          mode: 700
        /var/run/docker.sock:
          bind: /var/run/docker.sock
          type: socket
        /srv/log/nginx-proxy:
          bind: /var/log/nginx
          user: nobody
          group: nogroup
          logrotate: True
