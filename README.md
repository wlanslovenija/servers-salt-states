# Servers

This repository contains [Salt](http://docs.saltstack.com/en/latest/) files to deploy various *wlan slovenija* servers.
Expected to be used with Ubuntu Server 16.04, but it might work with other distributions
as well.

## Local installation

To deploy a server you first have to configure your machine. Then you run Salt which connects
to the target server and deploys it.

Clone the repository, including all submodules:

```bash
$ git clone --recursive git@github.com:wlanslovenija/wlanslovenija-servers.git
```

If you need to refresh submodules at any point, you can run:

```bash
$ git submodule update --init --recursive
```

Install `salt-ssh` using `virtualenv`:

```bash
# Create a Python 2 virtualenv, for example:
$ virtualenv --python=python2.7 --no-site-packages salt-virtualenv
$ source salt-virtualenv/bin/activate

# Install salt and all dependencies:
$ pip install -r requirements.txt

# Check version of salt-ssh
$ salt-ssh --version
# salt-ssh 2017.7.2 (Nitrogen)
```

We are currently using an old version of Salt (2017.7.2) and Python 2.

You should create a `config/roster` file with something like (replacing `<username>` with your username):

```
{% for host in [
  'aggregator.wlan-si.net',
] %}
{{ host.split('.')[0] }}:
  host: {{ host }}
  port: 22
  user: <username>
  sudo: True
{% endfor %}
```

Import all used GPG keys:

```bash
$ gpg --import gpg-keys/*.pub
```

## Deploying

If server has already been deployed with Salt in the past, then syncing the new sate to the server can done by:

```bash
$ salt-ssh '<servername>' state.highstate
```

This will update everything, pull down new/updated Docker images, and update/restart/recreate Docker containers.
You can run it against multiple servers at once. For each server you should look for summary like:

```
Summary for aggregator
--------------
Succeeded: 123 (changed=9)
Failed:      0
Warnings:   11
--------------
Total states run:     123
Total run time:   104.469 s
```

If there are any failures, you should investigate them, fix them, and re-deploy.

If you are connecting to the server for the first time by running a Salt command, you should run it as
`salt-ssh --ignore-host-keys ...` to auto-accept the server's SSH key.

**If you are making any changes to files in this repository and deploying a server, do not forget to
commit and push your changes as soon as possible. The repository and deployed servers should be out
of sync as little as possible.**

## Secrets

Secrets are encrypted with GPG keys to be protected.
New secrets can be encrypted using (with all keys from [`gpg-keys`](./gpg-keys)):

```bash
$ echo -n "supersecret" | gpg --armor --encrypt -r 86CBB63B98C753FC -r D2C5CA66EBF32285
```

You can also just run the `gpg` command above and copy-paste the secret in.
Do note that copy-pasting will add a newline at the end of the secret, which might not be what you want.

To decrypt existing secret so that you can modify it, copy-paste it into:

```bash
$ gpg --decrypt
```

[See Salt GPG renderer documentation for more information](https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html).

## Adding a new server

Currently we support Ubuntu Server 16.04 installed on the server, but it might work with newer
versions as well.

Adding a new server is slightly a chicken and an egg problem. The best is to first create a
user with your username and add it to the `sudo` group.
Add your public SSH key to `/home/<username>/.ssh/authorized_keys`.

Your user on the target server should have sudo permissions without needing to provide a password.
You can configure that in `/etc/sudoers` on the target server with such line (you can replace existing
one without `NOPASSWD`):

```
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL) NOPASSWD: ALL
```

Also run on the server:

```bash
$ apt-get update
$ apt-get install python2 python-concurrent.futures
```

This installs dependencies Salt needs to run on the server.

New server should then be added to:

* `config/roster` template in this README file
* [`states/top.sls`](./states/top.sls) (if needed to configure special states for the server)
* `pillars/<new server>.sls` and [`pillars/top.sls`](./pillars/top.sls)

## Source Code, Issue Tracker and Mailing List

For development *wlan slovenija* open wireless network [development Trac](https://dev.wlan-si.net/)
is used, so you can see [existing open tickets](https://dev.wlan-si.net/report)
or [open a new one](https://dev.wlan-si.net/newticket) there. Source
code is available on [GitHub](https://github.com/wlanslovenija/servers-salt-states).
If you have any questions or if you want to
discuss the project, use [development mailing list](https://wlan-si.net/lists/info/development).
