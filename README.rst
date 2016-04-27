wlan slovenija servers installation
===================================

This repository contains Salt_ states and pillar data that
enable configuration of various *wlan slovenija* servers.

.. _Salt: http://docs.saltstack.com/en/latest/
.. _tozd/salt: https://github.com/tozd/salt

An example Salt configuration, which may be used with ``salt-ssh`` follows::

    pki_dir: /home/wlanslovenija/servers/config/pki
    cachedir: /tmp/salt-cache
    jinja_trim_blocks: True
    jinja_lstrip_blocks: True
    gpg_keydir: /home/wlanslovenija/.gnupg
    file_roots:
      base:
        - /home/wlanslovenija/servers/states
        - /home/wlanslovenija/tozd
    pillar_roots:
      base:
        - /home/wlanslovenija/servers/pillars

You can put it into the ``config/master`` file under this repository.

In this example, the ``servers`` directory contains a checkout of this repository, while
the ``tozd`` directory is a checkout of the `tozd/salt repository`_,
containing commonly used Salt states.

You should put SSH keys used by ``salt-ssh`` to login into servers into the ``config/pki``
directory under this repository.

You should also create a ``config/roster`` file with something like::

    aggregator:
      host: aggregator.wlan-si.net
      port: 22
      user: <username>
      sudo: True

Secrets are encrypted with a GPG keypair to be protected. Future secrets can be encrypted using::

    echo -n "supersecret" | gpg --armor --encrypt -r <keyid>

`See Salt GPG renderer documentation for more information`_.

.. _tozd/salt repository: https://github.com/tozd/salt
.. _See Salt GPG renderer documentation for more information: https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html

Source Code, Issue Tracker and Mailing List
-------------------------------------------

For development *wlan slovenija* open wireless network `development Trac`_ is
used, so you can see `existing open tickets`_ or `open a new one`_ there. Source
code is available on GitHub_. If you have any questions or if you want to
discuss the project, use `development mailing list`_.

.. _development Trac: https://dev.wlan-si.net/
.. _existing open tickets: https://dev.wlan-si.net/report
.. _open a new one: https://dev.wlan-si.net/newticket
.. _GitHub: https://github.com/wlanslovenija/servers-salt-states
.. _development mailing list: https://wlan-si.net/lists/info/development
