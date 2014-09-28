#!yaml|gpg
docker:
  containers:
    nodewatcher-frontend:
      image: wlanslovenija/nodewatcher-frontend
      links:
        postgresql: db
        tokumx: tokumx
      environment:
        DJANGO_SETTINGS_MODULE: nodewatcher.settings_production
        SECRET_KEY: |
          -----BEGIN PGP MESSAGE-----
          Version: GnuPG v1

          hQIMAwUBEMdGLj08AQ/6AyACTvVpHBTfmE+FGTVohx25SBcojRDNqrOl5spNGgjg
          gVSvQ+tObKnxoDRTr55cd8sqMcqvDiMKYMtscFjXp2nq/lmbR/gTvJ7PSlJxVVLL
          nEvZkdJCdP0pd/k54/mACpU6TVTNvDdxENeWCYEty2EODtf0P6lPxPTwDFECoRh4
          vY7UDrwkmVzmls1u0jex5gLgO5Wz/pgcVxXdQ6atyCgZx1jpoMjXzumsPSp9XxFd
          dnOEbOqB6Dm+4t6AuehNKURfjkw0umI6apuyUVyZ4K4nlqbxsLUmK8gTE/J2YM+O
          fM82U66U57HTnJxxzkyZ5YObWBdJoU3VJZcU2+3DIag6nMWyfwqRJ6dp3CWAvYLp
          A8gN2fDeHynd2nO4Zl88T0K7sf9sqEI6Lziw0rK2LWLyf8lVBPUHJssVsDjx4SPi
          aDec04tk2zkouIzd+aFxPysUKGJECHQDf5RtltDH+Sk3dviWSqjElAqkUjHohAdh
          HKFgu4atmDqQ5GBF2a9kZ/XPkWt5iS2LBnPUgFadEX6dj0kf9bzCc32EqIjVd2mp
          zVuzXcOnDHGa97p1w9B6gtoBcP4Yr+NlEXMjnrptFi7pR0fcgJ2zuYaKkMVhiZ+B
          BzAHZsysQne0pl5LNi6OJnVJZy1YQpu51MDvh7MbQ+L5JoEl24kkkTWLErnqH+/S
          dwEIqasenDpDbS7z/aqu+RSRUWiaD8N1eYLSGVzmz7Rp3FWbRN/cvZi3ppBWc+t5
          j6L6fnE0gLsO4Wvtq8usWg+iR+SM1oWwdCqHO8kBEpDgMONb92OVH47LirTekAb0
          6tvi3sCPvfsPCB25+DLlwKcF9tq5aHic
          =VduC
          -----END PGP MESSAGE-----
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
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
              'PASSWORD': os.environ.get('DB_ENV_PGSQL_ROLE_1_PASSWORD', ''),
              'HOST': 'db',
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
