raid:
  arrays:
    /dev/md/0:
      uuid: 72461eb4:b42a82e0:940e31c5:1fe73892
      name: aggregator:0
      personality: raid1
      spares: 1
      devices:
        - /dev/sda2
        - /dev/sdb2
        - /dev/sdc2
