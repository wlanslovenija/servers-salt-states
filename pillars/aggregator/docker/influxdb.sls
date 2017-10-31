docker:
  containers:
    influxdb:
      image: tozd/influxdb
      network_mode:
        name: nodewatcher
      volumes:
        /srv/storage/influxdb:
          bind: /data
        /srv/log/influxdb:
          bind: /var/log/influxdb
          user: nobody
          group: nogroup
