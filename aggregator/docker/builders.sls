docker:
  containers:
    # Barrier Breaker
    builder-openwrt-vb92e821-bb-ar71xx:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_bb_ar71xx
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/barrier_breaker/ar71xx/
    builder-openwrt-vb92e821-bb-ar71xx_mikrotik:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_bb_ar71xx_mikrotik
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/barrier_breaker/ar71xx_mikrotik/
    builder-openwrt-vb92e821-bb-lantiq:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_bb_lantiq
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/barrier_breaker/lantiq/
    builder-openwrt-vb92e821-bb-x86:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_bb_x86
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/barrier_breaker/x86/
    builder-openwrt-vb92e821-bb-brcm2708:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_bb_brcm2708
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/barrier_breaker/brcm2708/
    # Chaos Calmer
    builder-openwrt-vb92e821-cc-ar71xx:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_cc_ar71xx
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/chaos_calmer/ar71xx/
    builder-openwrt-vb92e821-cc-ar71xx_mikrotik:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_cc_ar71xx_mikrotik
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/chaos_calmer/ar71xx_mikrotik/
    builder-openwrt-vb92e821-cc-lantiq:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_cc_lantiq
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/chaos_calmer/lantiq/
    builder-openwrt-vb92e821-cc-x86:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_cc_x86
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/chaos_calmer/x86/
    builder-openwrt-vb92e821-cc-brcm2708:
      image: wlanslovenija/openwrt-builder
      tag: vb92e821_cc_brcm2708
      environment:
        BUILDER_PUBLIC_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdqJhdBCJB3oMkhw0WiJ+JPrZjNQ2d8QVFx0BuuzRrDrQinuwcwNIzTcDBwzRhH53Z4Dx4nEMyNorZJwSWtMBUYlEHprZfc6x6/uOyb0c7bMg4VpQhrhJsSx2VLyzee/XtCNpo51qTkq/FoNXYx3xjgWVjwJ3iWZ46526Voru7hYlzDW8XOwqXAEpdnfnXIa37xj/Aopn1x7q7CaGXy7ASvbM46dXDHFSfpLn+NYTHQCbM07oHcTXoTfcMaCAX6Ot9tJ0G2tlY7IiXuQIQlnNRVezYn9gzzQpP5UZ9km3njMb+AlFjtyAJaKUngnzGteUk73K0Clwwu7qmSHZQbI5n builder@wlan-si.net
        VIRTUAL_HOST: packages.wlan-si.net
        VIRTUAL_URL: /firmware/git.b92e821/openwrt/chaos_calmer/brcm2708/
