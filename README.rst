wlan slovenija servers installation
===================================

This repository contains Salt_ files to deploy various *wlan slovenija* servers.
Expected to be used with Ubuntu Server 14.04 and 16.04, but it might work with other distributions
as well.

.. _Salt: http://docs.saltstack.com/en/latest/

You should create a ``config/roster`` file with something like::

    aggregator:
      host: aggregator.wlan-si.net
      port: 22
      user: <username>
      sudo: True

Your user on the target server should have sudo permissions without needing to provide a password.
You can configure that in ``/etc/sudoers`` on the target server with such line (you can replace existing
one without ``NOPASSWD``)::

    # Allow members of group sudo to execute any command
    %sudo   ALL=(ALL) NOPASSWD: ALL

Then you can sync the state of a server by doing::

    $ salt-ssh '<servername>' state.highstate

Secrets are encrypted with a GPG keypair to be protected. Future secrets can be encrypted using::

    echo -n "supersecret" | gpg --armor --encrypt -r <keyid>

`See Salt GPG renderer documentation for more information`_.

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
