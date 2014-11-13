#!yaml|gpg
docker:
  containers:
    nodewatcher-frontend:
      image: wlanslovenija/nodewatcher-frontend
      links:
        postgresql: postgresql
        tokumx: tokumx
      environment:
        VIRTUAL_HOST: beta.wlan-si.net
        VIRTUAL_URL: /
        DJANGO_SETTINGS_MODULE: nodewatcher.settings_production
        SECRET_KEY: |
          -----BEGIN PGP MESSAGE-----
          Version: GnuPG v2.0.22 (GNU/Linux)

          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
          =vFkj
          -----END PGP MESSAGE-----
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/discovery/hosts:
          bind: /etc/hosts
          type: container
          container: discovery
          readonly: True
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/storage/nodewatcher/static:
          bind: /static
        /srv/log/nodewatcher/uwsgi:
          bind: /var/log/uwsgi
          user: nobody
          group: nogroup
          logrotate: True
    nodewatcher-generator:
      image: wlanslovenija/nodewatcher-generator
      links:
        postgresql: postgresql
        tokumx: tokumx
      environment:
        DJANGO_SETTINGS_MODULE: nodewatcher.settings_production
        SECRET_KEY: |
          -----BEGIN PGP MESSAGE-----
          Version: GnuPG v2.0.22 (GNU/Linux)

          hQIMAyJISh0cw3JhARAAo9oeVDpU5L+HMYHz5huyVJYG0tejzMYbG6cfcHx/nASz
          drDimQuhxdyIpD+MP3KaGYuB3EOgA/F3z7ts/d4cx3//xi4WE9reNChW7tsj9l/w
          LVvRKF8nJ+dtb7fV0PbW+nl1iwmrw4O3rrlpVq8v5Z3Z61utBiGE4lCyyl2Seat+
          umV7hL2HIeRebUuzBYtW/BFR+WckFFvTbGiHAJZINi1xNeNMFUbigMfXZvxepdHx
          QNcVe7bkaFbV33i10USpcgUN9jk2XEQcdNxQuDSoQukIbqN4J9x5iTF8V1aLbUZl
          UcgsrwLGyK0FYxgNVEMGTD/gBLpCyDsxjhXnq7QIGGwhXXjsg13ET7uppWPfx6Wz
          P8vHQU7WK+WsUBIhFXwuCilgiTtAz7e8BJXqjW/M0ZcAen+HLtVqZBRWXYozTvR5
          uAdS2AZxVUvrvG3LVjAdMYTON+y32XGiqG7+GKjMZgkFZQ0HkiBc7BCCf3oScefj
          5W1n3wv6JQoLboLMsjXdqoZYWDixDLRCvy+FB0JiucYs00KXJztvisbZVoyLj9o0
          iyIStmFJUu+P/CF0uNCtchJbHf9l7hzJiJyHUevOaBb02qULGmCuqQwkmCM0Fxq6
          mxb1cAAdeGndj1QpMK0JjBrvJJFK6kj1MMhia+qGEvMC/d2UK03Y+XTvxitYfWaF
          Aw0DeBXII627AVcQDACN/ROctOCKeUdPOuTFybLkfbS9hidLkKamjGqVvE+CcZhs
          6JMDRyEj8akkXNgEn12OJTrhPtzWlULEQ3ZJzLC9JOWg9/cYCkZ7Xlc+q5qT9Y4U
          X7kgHxnd5UHXz6kBiBiX9TVVq2HPhuDp8pcRQ9hNt4hMvAeaNKk8JNG1Ac7GyDpd
          vE5cMhARMT7x3mbSmzGNcReki0EkBLUuXnftlQOC2vDMfRigh4+eaLhnVOuqLCeY
          o9WrIXJWL5/oY4sDjZYgbNuUTFUJi8rEOnXcc3G9Zedlnean98R4DJhj2U97fEsM
          qih8nMYb89gzy2M/Z3egjfA3E+xfnjAXouuvgVFpSgMd+tMqj43xAVoYU4Qg6MmD
          xzQa56Hw3k32UDAWD4gPjAUPFhOroZA5kd/uZjgBuHG/2m0a9ZIRJbGQiADW2MO1
          vJlgmPzWWyBi/AQCGuV7AHSB3hcUxpIkW2ScQmqeZK4qupbUXsjrmbVfrn8xPDQQ
          Cx8MF4GOqtX//9DSPfUL+Msatju01HDX5DUJtrxBOHN6FhicqLXtyGg8lGiagiXr
          gFnFic+5uVvQZ+x+Sfwc2jdgLEcSwbZKzWZhZIzviH5U5J3s83ABfh1Q+JiqtT2J
          Tjm/4Iq+fZ0g0pDylhJFmaoyOoImO+Xr7Fca1Ve2IC2Glqq+QzUIMNFhsffN7ka/
          EblxdySch1B/CZsrnHb0OVVKqfUKmU9W1IIa2CbJ5HiHuTYkTYRcgs2j8D0/8zeA
          u3ealcqVRmhIl/zHyA5DGLUOdqiaubTZ/TDclVoEM2e2V1uYNj3BdT8kpLzSSTbn
          wJet0g0+IZswufSoS57spY3X5BzV4xlDmESp0vO5TzBiCMOZ1xgFgn+0PeegpLlr
          nqfhBaEsHgvHGO1jUikl1s/LyiXs+xuMwrAgXXn0R3BjHqYf2//2FgaKTXmWlgTL
          JSB3wrxKaXI2gdbiFg8VyQdlcCgHdtPadr2z2gm9pTuODw//IFczvImCtioODv10
          GPCsfex2sL8c4A8K8P9m0ncBJgxHMY4fbCVnx6BzzcZSZ+35BQpOVkFgTjtSNT+J
          P84NRdF3XBldmq6PtSkT38Za3Naq2JHSJSADjFwf/0iuIPpk4AhJ28TNSRm/5hMv
          pu1/ioGQTBVM1mfd/7O9Ox7gM/7gmOpcK2x1IJKZkBdEfkJzhun55Q==
          =vFkj
          -----END PGP MESSAGE-----
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/discovery/hosts:
          bind: /etc/hosts
          type: container
          container: discovery
          readonly: True
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/log/nodewatcher/generator:
          bind: /var/log/celery
          user: nobody
          group: nogroup
          logrotate: True
  configs:
    nodewatcher: |
      from .settings import *

      DEBUG = False
      TEMPLATE_DEBUG = False
      TEMPLATE_URL_RESOLVERS_DEBUG = False

      SECRET_KEY = os.environ.get('SECRET_KEY')

      DATABASES = {
          'default': {
              'ENGINE': 'django.contrib.gis.db.backends.postgis',
              'NAME': 'nodewatcher',
              'USER': 'nodewatcher',
              'PASSWORD': os.environ.get('POSTGRESQL_ENV_PGSQL_ROLE_1_PASSWORD', ''),
              'HOST': 'postgresql',
              'PORT': '5432',
          }
      }

      MEDIA_ROOT = '/media'
      STATIC_ROOT = '/static'

      EMAIL_HOST = ''
      DEFAULT_FROM_EMAIL = 'notifications@nodes.wlan-si.net'

      CELERY_RESULT_BACKEND = 'mongodb'
      CELERY_MONGODB_BACKEND_SETTINGS = {
        'host': 'tokumx',
        'port': '27017',
        'database': 'nodewatcher_celery',
        'taskmeta_collection': 'celery_taskmeta',
        'options': {
          'tz_aware': USE_TZ,
        }
      }

      BROKER_URL = 'mongodb://tokumx:27017/nodewatcher_celery'

      DATASTREAM_BACKEND = 'datastream.backends.mongodb.Backend'
      DATASTREAM_BACKEND_SETTINGS = {
        'database_name': 'nodewatcher_ds',
        'host': 'tokumx',
        'port': 27017,
        'tz_aware': USE_TZ,
      }

      OLSRD_MONITOR_HOST = 'olsrd'
      OLSRD_MONITOR_PORT = 2006

      MEASUREMENT_SOURCE_NODE = ''

      USE_HTTPS = True

      GOOGLE_MAPS_API_KEY = ''

      ALLOWED_HOSTS = [
        os.environ.get('VIRTUAL_HOST', '127.0.0.1'),
      ]
