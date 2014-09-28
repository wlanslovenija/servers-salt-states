#!yaml|gpg
docker:
  containers:
    postgresql:
      image: wlanslovenija/postgis
      volumes:
        /srv/storage/postgresql:
          bind: /var/lib/postgresql/9.3/main
          user: 119
          group: 128
        /srv/log/postgresql:
          bind: /var/log/postgresql
          user: nobody
          group: nogroup
          logrotate: True
      environment:
        PGSQL_ROLE_1_USERNAME: nodewatcher
        PGSQL_ROLE_1_PASSWORD: |
          -----BEGIN PGP MESSAGE-----
          Version: GnuPG v1

          hQIMAwUBEMdGLj08AQ//SMaeHfG0+1l0OdOplFq1fIBJtrgp096XzhpM0CqDj39L
          o4bQyAv4W2eIsz1hW8XvCowLnO5C49duHWLCN0kc7PwtNnzPzRnoqYIaz0JT7O2S
          zmRiUiTKAlBBGJLsT4yTe+UiDF4iN2Ya0AWOXrG9Y5hgGA8XHquFHNi2kLhuqZwv
          dGz57dh6fFtjnYBRNTDMVL2On67pIDz8gyvrz5JC+OUXCQ+LAQ/w1gbY8/ZHl0Q6
          kJEZoYhNk7fKBnY6RMLZvK/IclZQ5xXzwVscCJgpW9yqL07H3BywEozN9Hyg6UgH
          YtDrEZfiD9jLajReo5eRMhaDt7gey+he08naNNNo3xQIuPkejtmpcY5SuYMS0CLt
          KJ+sTj+nZ6vh5UOIvTKJrmiMfy5fksEEvApWaLACGcSfvXAgowPSVkRXxS6nTjG9
          QSz8QT08t3UmxQXMYzcph3Iek/dhCpWew4EGTKU0j8SlsFxq/NkFeNiJ3cZIpKlU
          2Iy7tveOM68fTQnyNFDLXeRJqkIxgyHyStpo/m1N6olhlPDkA1McENl4nYzTiZs8
          zkcHWVdjG0RODI9DC8fx8ZXIxo01IyroPkg/UI8Tu2E4/CQxo117MI6EIL9FC7bz
          JnMU5WiOfZC0W5qZYjF2owUEOPuQfen3FXQJbNUAlkmLNziRhO8iAtQWFxFSDR7S
          awEgsiHJ5zMVOe1STm7bLB63ZAHkHwlFnSN6dyJuAw3KU+Pdfj6S5Zk8xhR+x8tj
          j/JzHOLTKHJ54fJJQfWmgZihqRIuVzkmmT8fUTaZlnEXCyKY9AxsffwUWzHkpTN7
          5KgL4lY/rXYO3Uaa
          =Od+A
          -----END PGP MESSAGE-----
        PGSQL_ROLE_1_FLAGS: LOGIN
        PGSQL_DB_1_NAME: nodewatcher
        PGSQL_DB_1_OWNER: nodewatcher
        PGSQL_DB_1_ENCODING: UNICODE
