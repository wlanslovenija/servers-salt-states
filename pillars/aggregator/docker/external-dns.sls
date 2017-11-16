# One has to create /srv/storage/external-dns/bind/superslave.conf manually after deploying with 102:105 owner.

docker:
  containers:
    external-dns:
      image: tozd/powerdns
      network_mode:
        name: nodewatcher
      ports:
        53/tcp:
          ip: 212.101.139.12
          port: 53
        53/udp:
          ip: 212.101.139.12
          port: 53
      volumes:
        /srv/storage/external-dns/pdns.d:
          bind: /etc/powerdns/pdns.d
        /srv/storage/external-dns/bind:
          bind: /etc/powerdns/bind
          user: 102
          group: 105
        /srv/storage/external-dns/bindbackend.conf:
          bind: /etc/powerdns/bindbackend.conf
          type: file
        /srv/storage/external-dns/supermasters.conf:
          bind: /etc/powerdns/supermasters.conf
          type: file
        /srv/log/external-dns:
          bind: /var/log/powerdns
      files:
        /srv/storage/external-dns/pdns.d/pdns.conf: |
          # Managed by Salt.
          # Disable recursion
          allow-recursion=

          # We use runit to assure the process is running.
          guardian=no
          daemon=no

          # DNS master & slave.
          master=no
          slave=yes

          # To be anonymous.
          version-string=anonymous
        /srv/storage/external-dns/pdns.d/pdns.simplebind.conf: |
          # Managed by Salt.
          launch=bind
          bind-config=/etc/powerdns/bindbackend.conf
          bind-supermasters=/etc/powerdns/supermasters.conf
          bind-supermaster-config=/etc/powerdns/bind/superslave.conf
          bind-supermaster-destdir=/etc/powerdns/bind
        /srv/storage/external-dns/bindbackend.conf: |
          # Managed by Salt.
          options {
            directory "/etc/powerdns/bind";
          };

          include "superslave.conf";
        /srv/storage/external-dns/supermasters.conf: |
          # Managed by Salt.
          46.54.226.40 ns1
          46.54.226.44 ns1
