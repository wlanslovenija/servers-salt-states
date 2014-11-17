docker:
  containers:
    builder-openwrt-v4c6afc4-bb-ar71xx:
      image: wlanslovenija/openwrt-builder
      tag: v4c6afc4_bb_ar71xx
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCho6FII0iKbpU+DpJqS9ARtn4jaXZAuc86QkaCc0FCKaaQh2QofgzTsibPICksyXfxRJM5rlEwwAf6RweGrtqM49pZGvmhS0fhoComGNC2qANDkAPlvAhs2JPp/jFeH7wDVUQr+D1Noc4daObddC7rrRtNa0ch9nAfYCTJcxSFp69VcUij9IX7O660w4CL2fL8ya/P43f2IZVqcFefPeY5/TydeE8GMZQo5L+7RKMR9rhZ4JY9CQbQgCkhl9IQ2Oc46dTDoUtxe556EWp3gqBRvd4CXcMlDS3jd1OvW5HHJLIgQ66uuS8C9I5VbzcpxpV+qfOxEeWXGRhd0V9H6/2n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.4c6afc4/openwrt/barrier_breaker/ar71xx/
    builder-openwrt-v4c6afc4-cc-ar71xx:
      image: wlanslovenija/openwrt-builder
      tag: v4c6afc4_cc_ar71xx
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCho6FII0iKbpU+DpJqS9ARtn4jaXZAuc86QkaCc0FCKaaQh2QofgzTsibPICksyXfxRJM5rlEwwAf6RweGrtqM49pZGvmhS0fhoComGNC2qANDkAPlvAhs2JPp/jFeH7wDVUQr+D1Noc4daObddC7rrRtNa0ch9nAfYCTJcxSFp69VcUij9IX7O660w4CL2fL8ya/P43f2IZVqcFefPeY5/TydeE8GMZQo5L+7RKMR9rhZ4JY9CQbQgCkhl9IQ2Oc46dTDoUtxe556EWp3gqBRvd4CXcMlDS3jd1OvW5HHJLIgQ66uuS8C9I5VbzcpxpV+qfOxEeWXGRhd0V9H6/2n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.4c6afc4/openwrt/chaos_calmer/ar71xx/
