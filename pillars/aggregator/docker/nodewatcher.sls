#!yaml|gpg
docker:
  containers:
    nodewatcher-frontend:
      image: wlanslovenija/nodewatcher-frontend
      environment:
        # We use a different virtual host for pushing monitoring data as we configure
        # TLS client authentication there.
        - VIRTUAL_HOST: beta.wlan-si.net,nodes.wlan-si.net,push.nodes.wlan-si.net
          VIRTUAL_URL: /
          VIRTUAL_LETSENCRYPT: "true"
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      files:
        /srv/storage/ssl/push.nodes.wlan-si.net_nonssl.conf: |
          # Allow push without SSL (needed for simple sensors). There is still a
          # per-node configuration that determines whether this should be allowed.
          location /push/http/ {
            proxy_pass http://push.nodes.wlan-si.net-u;
          }
        /srv/storage/ssl/push.nodes.wlan-si.net_ssl.conf: |
          # Setup client authentication. Allow authentication with any certificate
          # as all verification is done by the nodewatcher modules.
          ssl_verify_client optional_no_ca;

          # Accept push requests.
          location ~ ^/push/http[/$] {
            proxy_pass http://push.nodes.wlan-si.net-u;
          }

          # Redirect all other requests to the main site.
          location ~ / {
            return 301 https://nodes.wlan-si.net$request_uri;
          }
        /srv/storage/ssl/beta.wlan-si.net_ssl.conf: |
          # Redirect push requests to its proper virtual host.
          location /push/http/ {
            return 301 https://push.nodes.wlan-si.net$request_uri;
          }

          # Redirect all requests to main site.
          location ~ / {
            return 301 https://nodes.wlan-si.net$request_uri;
          }
        /srv/storage/ssl/nodes.wlan-si.net_ssl.conf: |
          # Redirect push requests to its proper virtual host.
          location /push/http/ {
            return 301 https://push.nodes.wlan-si.net$request_uri;
          }
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
    nodewatcher-generator:
      image: wlanslovenija/nodewatcher-generator
      environment:
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/log/nodewatcher/generator:
          bind: /var/log/celery
          user: nobody
          group: nogroup
    nodewatcher-monitor:
      image: wlanslovenija/nodewatcher-monitor
      network_mode:
        type: container
        container: mesh-network
      environment:
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/log/nodewatcher/monitor:
          bind: /var/log/monitor
          user: nobody
          group: nogroup
    nodewatcher-monitorq:
      image: wlanslovenija/nodewatcher-monitorq
      network_mode:
        type: container
        container: mesh-network
      environment:
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/log/nodewatcher/monitorq:
          bind: /var/log/celery
          user: nobody
          group: nogroup
  environments:
    nodewatcher:
      DJANGO_SETTINGS_MODULE: nodewatcher.settings_production
      SECRET_KEY: |
        -----BEGIN PGP MESSAGE-----
        Version: GnuPG v2.0.22 (GNU/Linux)

        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
        =vFkj
        -----END PGP MESSAGE-----
  configs:
    nodewatcher: |
      from .settings import *

      DEBUG = False
      TEMPLATE_DEBUG = DEBUG
      TEMPLATE_URL_RESOLVERS_DEBUG = DEBUG

      SECRET_KEY = os.environ.get('SECRET_KEY')

      ADMINS = (
        ('Jernej Kos', 'jernej@kos.mx'),
        ('Mitar', 'mitar.nodewatcher@tnode.com'),
      )

      MANAGERS = ADMINS

      DATABASES = {
          'default': {
              'ENGINE': 'django.contrib.gis.db.backends.postgis',
              'NAME': 'nodewatcher',
              'USER': 'nodewatcher',
              'PASSWORD': os.environ.get('PGSQL_ROLE_1_PASSWORD', ''),
              'HOST': 'postgresql',
              'PORT': '5432',
          }
      }

      TIME_ZONE = 'Europe/Ljubljana'

      MEDIA_ROOT = '/media'
      STATIC_ROOT = '/static'

      EMAIL_HOST = 'mail.tnode.com'
      EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'

      BROKER_URL = 'redis://redis:6379/0'
      CELERY_RESULT_BACKEND = BROKER_URL

      DATASTREAM_BACKEND = 'datastream.backends.influxdb.Backend'
      DATASTREAM_BACKEND_SETTINGS = {
          'connection_influxdb': {
              'host': 'influxdb',
              'port': 8086,
              'database': 'nodewatcher'
          },
          'connection_metadata': {
              'host': DATABASES['default']['HOST'],
              'port': DATABASES['default']['PORT'],
              'database': DATABASES['default']['NAME'],
              'user': DATABASES['default']['USER'],
              'password': DATABASES['default']['PASSWORD'],
          },
      }

      OLSRD_MONITOR_HOST = '127.0.0.1'
      OLSRD_MONITOR_PORT = 2006

      MONITOR_HTTP_PUSH_HOST = 'push.nodes.wlan-si.net'

      MEASUREMENT_SOURCE_NODE = '5dcf6dae-9246-47ec-8ba5-f864d8f88778'

      USE_HTTPS = True
      CSRF_COOKIE_SECURE = USE_HTTPS
      SESSION_COOKIE_SECURE = USE_HTTPS
      SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

      AUTHENTICATION_BACKENDS += (
          'nodewatcher.extra.accounts.auth.AprBackend',
          'nodewatcher.extra.accounts.auth.CryptBackend',
      )

      HTTPS_PUBLIC_KEY = """
      -----BEGIN PUBLIC KEY-----
      MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2gCARJCGa4PmrAyRxKp5
      DvjVYRAFVZI25ACOHmTUSz6pp10hH8V6xp3ubbTnROG25K0xMjvHVjqH+ZrKtetr
      iU9ShvRhY0wFM3BjdTzD0qAKvHFBlRrqT+Lx+7f739ZfGCVQ6FeaWuDRMLDv4uhm
      4QIIOCBX9Kaj1DR2ayABsw05mFR5KrAu6HGLH22dDebhcMOueO4nR0PeOlaKBjuH
      +F0h/FKz8gqofd3VR+J/C+h9+SzanXGJXGr6vhxIfshkSnuv2BneYNAg2CY0Ft0b
      dO55GDbaQZHbKTnA0Cg+V9H4x/ArdmGfeEm6UE8TCoQHr6zAGPJ5e7XIzE4fvAS4
      qgctt7vH1QJ3YUI72HAQjyARQ+9VPo6YfdtMXac5s3tMfvKz4Ks9Bf+kVbCF40/t
      ZQvUCFIjc8ntqPZZ4Ml5I5RQ7JPnEcNTRcF9Dn2qGBTqRyi+J3HCP993djzP5AI3
      ZbNH4aN8zXdstxXOu5DQraQ+V8cCSEEErgfjcqK2MTAejBqBefWy1mLad04Ai4/l
      TfWWO8OUUgTALqNHA9B6e2za5ORkteAc1/wXznM+KdGoWGF69Q2e6BisA7scLY9W
      uRQ+n/hMQ+vvFqM0xpv6PTl7X8uqXamTUjviSpS2ebcMwTJ2ZTMa7H5xERu4iaPT
      lCPkcr8951RzeYJljgbqdmECAwEAAQ==
      -----END PUBLIC KEY-----
      """

      NODEUPGRADE_SERVER = '10.254.0.6'
      NODEUPGRADE_PORT = 28932
      NODEUPGRADE_USER = 'fileserver'
      NODEUPGRADE_PRIVATE_KEY = """
      AAAAB3NzaC1yc2EAAAADAQABAAABAQC1M6TGKaUX9k6B/NJPwpJlKaTEu9LBaEiMVLz+9NaKituc
      8IB9Ynm/r07rRq65AXSu+bHBO9431TPiRRQ3oak7nlXhIWTUL2oH4DnwFbmFm5/NkFdP9p+PYcn9
      YnhmWGAGFFdKGDuiGHcbVH/bulvZobBC2EDvDOlg1iA2/Xx9Jdgyq8t6M0iIxaEQydGxNa/2JpfR
      u4O9uHq3+LZjM6i4/X2IY9JYFPUUMhnZ80uHBrjWHXZgBEyF9aT01PXvGejxJ5D4UDVe2UT6Tbl1
      /w/zEq9BnNt1ZggXUz7S/h2xrlZMrVMDDEnBE2Mbq1tHXyHeEoclLMG9RIpF/osG1Ja3AAABADb5
      WxVPzyms7XacaIYQRu/wKXASd8d7xv7kOo6zY1+W7zf281SXCs7v9eaFhD7WxTrMwHQaoLmZsmsE
      gDS8lCZlTDLIOdnyJJ4NFibTwHxbkakBEKxO62vJxElelZ6fU0qk4zK0lWsBNymQglX8fR9S4bH2
      AAVGiot5iz6Du0AQNrpZA2gdkoNHR01oITmZOzpQ1g7aU4EE0eni2lwW4GJsugvU4sx51MTKEoSZ
      1U+zlN+L8hMPcoaSfv6OOW616ct8eopdXi7mOkZ/87UFjUY6WtySYO90n6YjN9LLpD2iLlHyIfjZ
      uwu7mFYebvH9HtO+6d6G99JexdmrNhcrXTkAAACBAPEJtenGdpWlonhTbJe9x3QKkQtsMwC41OmD
      d7AEVI/8thRRIRFUMpAoThzAD7q37wnw7/I1j6tAawZQRxhmqHPbC69ro/fcuhg/MDOs7rFKXXtn
      shhInQwUjP2pU6g8SN9RRntuC+7hTSHRB25jaW/7weJt1Jpt0xIgE4JGeivLAAAAgQDAcxZHdD/J
      hiQ+/ggFsYdhvauCR9Z66oQfkkCRX5BOcoph4fMjQxgUxwfUYXVUCx5e9q19LKnWDB4FnnLNNTm9
      Reyg1xSZvl98FcR8sh3l3ZdvA6feW1xd6vg8rpWtdnJag1iuKY+HpgU256Ub6yf8/M2J+zmicg6s
      lWebI407RQ==
      """
      NODEUPGRADE_SERVER_PUBLIC_KEY = 'ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOzKxvjv/RFDOd2BE4HgxvqNsMljGiSRim7KUQNI/ifjvBe4Z325DBe78OJ6P9d2kf6omHUxnLi1oPu+YaEdDDk='

      NETWORK.update({
        'NAME': 'wlan slovenija',
        'HOME': 'https://wlan-si.net',
        'CONTACT': 'open@wlan-si.net',
        'CONTACT_PAGE': 'http://wlan-si.net/contact/',
        'DESCRIPTION': 'open wireless network of Slovenia',
        'FAVICON_FILE': 'wlansi/images/favicon.ico',
      })

      EMAIL_SUBJECT_PREFIX = '[' + NETWORK['NAME'] + '] '
      DEFAULT_FROM_EMAIL = NETWORK['CONTACT']
      SERVER_EMAIL = DEFAULT_FROM_EMAIL

      ALLOWED_HOSTS = os.environ.get('VIRTUAL_HOST', '127.0.0.1').split(',')

      TELEMETRY_PROCESSOR_PIPELINE = (
          # Validators should start here in order to obtain previous state.
          'nodewatcher.modules.monitor.validation.reboot.processors.RebootValidator',
          'nodewatcher.modules.monitor.validation.version.processors.VersionValidator',
          'nodewatcher.modules.monitor.validation.interfaces.processors.InterfaceValidator',
          # Telemetry processors should be below this point.
          'nodewatcher.modules.monitor.sources.http.processors.HTTPTelemetry',
          'nodewatcher.modules.monitor.http.general.processors.GeneralInfo',
          'nodewatcher.core.monitor.processors.GeneralInfo',
          'nodewatcher.modules.monitor.http.resources.processors.SystemStatus',
          'nodewatcher.modules.monitor.http.interfaces.processors.DatastreamInterfaces',
          'nodewatcher.modules.monitor.http.clients.processors.ClientInfo',
          'nodewatcher.modules.routing.olsr.processors.NodeTopology',
          'nodewatcher.modules.routing.babel.processors.BabelTopology',
          'nodewatcher.modules.sensors.generic.processors.GenericSensors',
          'nodewatcher.extra.irnas.koruzav2.processors.Koruza',
          'nodewatcher.extra.irnas.sfp.processors.SFP',
          'nodewatcher.modules.vpn.tunneldigger.processors.DatastreamTunneldigger',
          'nodewatcher.modules.administration.status.processors.NodeStatus',
          'nodewatcher.modules.monitor.datastream.processors.NodeDatastream',
      )

      MONITOR_RUNS = {
          'latency': {
              'workers': 5,
              'interval': 600,
              'processors': (
                  'nodewatcher.modules.routing.olsr.processors.GlobalTopology',
                  'nodewatcher.modules.routing.babel.processors.IncludeRoutableNodes',
                  'nodewatcher.modules.monitor.measurements.rtt.processors.RttMeasurement',
                  'nodewatcher.modules.monitor.datastream.processors.TrackRegistryModels',
                  'nodewatcher.modules.monitor.measurements.rtt.processors.StoreNode',
                  'nodewatcher.modules.administration.status.processors.NodeStatus',
                  'nodewatcher.modules.monitor.datastream.processors.NodeDatastream',
              ),
          },

          'telemetry': {
              'workers': 15,
              'interval': 300,
              'max_tasks_per_child': 50,
              'processors': (
                  'nodewatcher.core.monitor.processors.GetAllNodes',
                  'nodewatcher.modules.routing.olsr.processors.GlobalTopology',
                  'nodewatcher.modules.routing.babel.processors.IncludeRoutableNodes',
                  'nodewatcher.modules.monitor.datastream.processors.TrackRegistryModels',
                  'nodewatcher.modules.routing.olsr.processors.NodeTopology',
                  TELEMETRY_PROCESSOR_PIPELINE,
                  'nodewatcher.modules.monitor.datastream.processors.MaintenanceBackprocess',
                  'nodewatcher.modules.administration.status.processors.PushNodeStatus',
              ),
          },

          'telemetry-push': {
              # This run does not define any scheduling or worker information, so it will only be
              # executed on demand.
              'processors': (
                  'nodewatcher.modules.monitor.unknown_nodes.processors.DiscoverUnknownNodes',
                  'nodewatcher.modules.monitor.sources.http.processors.HTTPGetPushedNode',
                  'nodewatcher.modules.identity.public_key.processors.VerifyNodePublicKey',
                  'nodewatcher.modules.monitor.datastream.processors.TrackRegistryModels',
                  TELEMETRY_PROCESSOR_PIPELINE,
              ),
          },

          'topology': {
              'workers': 5,
              'interval': 60,
              'processors': (
                  'nodewatcher.modules.routing.olsr.processors.GlobalTopology',
                  'nodewatcher.modules.routing.olsr.processors.NodeTopology',
                  'nodewatcher.modules.monitor.topology.processors.Topology',
                  'nodewatcher.modules.monitor.datastream.processors.NetworkDatastream',
              ),
          },
      }
