docker:
  containers:
    nginx-proxy:
      image: wlanslovenija/nginx-proxy
      ports:
        80/tcp:
          ip: 212.101.139.12
          port: 80
      volumes:
        /var/run/docker.sock:
          bind: /var/run/docker.sock
          type: socket
        /srv/log/nginx-proxy:
          bind: /var/log/nginx
          user: nobody
          group: nogroup
          logrotate: True
