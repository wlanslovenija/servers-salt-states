#!yaml|gpg
docker:
  containers:
    postgresql:
      image: wlanslovenija/postgis
      volumes:
        /srv/storage/postgresql:
          bind: /var/lib/postgresql/9.3/main
          user: 102
          group: 106
        /srv/log/postgresql:
          bind: /var/log/postgresql
          user: nobody
          group: nogroup
          logrotate: True
      environment:
        - postgresql
  environments:
    postgresql:
      PGSQL_ROLE_1_USERNAME: nodewatcher
      PGSQL_ROLE_1_PASSWORD: |
        -----BEGIN PGP MESSAGE-----
        Version: GnuPG v2.0.22 (GNU/Linux)

        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
        arnKgeZr+MA3Ii/MCgviKV2mm41EjoxSq2PgHaU=
        =joj1
        -----END PGP MESSAGE-----
      PGSQL_ROLE_1_FLAGS: LOGIN
      PGSQL_DB_1_NAME: nodewatcher
      PGSQL_DB_1_OWNER: nodewatcher
      PGSQL_DB_1_ENCODING: UNICODE
