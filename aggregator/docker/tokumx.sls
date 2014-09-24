docker:
  containers:
    tokumx:
      image: wlanslovenija/tokumx
      sysctl:
        kernel.mm.transparent_hugepage.enabled: never
