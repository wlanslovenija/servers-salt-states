docker:
  containers:
    nginx-proxy:
      image: tozd/nginx-proxy
      tag: ubuntu-bionic
      network_mode:
        name: nodewatcher
      environment:
        - MAILTO: monitoring@unico.re,mitar.aggregator@tnode.com
          ADMINADDR: monitoring@unico.re,mitar.aggregator@tnode.com
          REMOTES: mail.tnode.com
          LETSENCRYPT_EMAIL: aggregator@unico.re
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
          mode: 701
        /var/run/docker.sock:
          bind: /var/run/docker.sock
          type: socket
        /srv/log/nginx-proxy:
          bind: /var/log/nginx
          user: nobody
          group: nogroup
