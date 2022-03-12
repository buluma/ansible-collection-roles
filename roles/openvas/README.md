ARCHIVED - openvas
=========

NOTA BENE: This repository has been archived, no maintenance is being performed anymore.

Install and configure openvas on your system.

|Travis|GitHub|Quality|Downloads|
|------|------|-------|---------|
|[![travis](https://travis-ci.org/robertdebock/ansible-role-openvas.svg?branch=master)](https://travis-ci.org/robertdebock/ansible-role-openvas)|[![github](https://github.com/robertdebock/ansible-role-openvas/workflows/Ansible%20Molecule/badge.svg)](https://github.com/robertdebock/ansible-role-openvas/actions)|![quality](https://img.shields.io/ansible/quality/46586)|![downloads](https://img.shields.io/ansible/role/d/46586)|

Example Playbook
----------------

This example is taken from `molecule/resources/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - robertdebock.openvas
```

The machine may need to be prepared using `molecule/resources/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  vars:
    # ca_privatekey_path: "/var/lib/openvas/CA/cacert.pem"
    ca_requests:
      - name: clientkey
        passphrase: WoNtT3L1
        cipher: aes256
        country_name: NL
        email_address: robert@meinit.nl
        organization_name: Some Corporation
        organizational_unit_name: Department X
      - name: serverkey
        passphrase: WoNtT3L1
        cipher: aes256
        country_name: NL
        email_address: robert@meinit.nl
        organization_name: Some Corporation
        organizational_unit_name: Department X

  roles:
    - robertdebock.bootstrap
    - robertdebock.buildtools
    - robertdebock.epel
    - robertdebock.python_pip
    - robertdebock.apt_autostart
    - robertdebock.redis
    - robertdebock.ca
```


Also see a [full explanation and example](https://robertdebock.nl/how-to-use-these-roles.html) on how to use these roles.

Role Variables
--------------

These variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for openvas

# The username for the openvas webinterface.
openvas_administrator_username: admin

# The password for the openvas webinterface.
openvas_administrator_password: password
```

Requirements
------------

- Access to a repository containing packages, likely on the internet.
- A recent version of Ansible. (Tests run on the current, previous and next release of Ansible.)

The following roles can be installed to ensure all requirements are met, using `ansible-galaxy install -r requirements.yml`:

```yaml
---
- robertdebock.bootstrap
- robertdebock.buildtools
- robertdebock.ca
- robertdebock.epel
- robertdebock.python_pip
- robertdebock.apt_autostart
- robertdebock.redis
- robertdebock.selinux
- robertdebock.reboot

```

Dependencies
------------

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- robertdebock.selinux
Context
-------

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://robertdebock.nl/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/robertdebock/drawings/artifacts/openvas.png "Dependency")


Compatibility
-------------

This role has been tested on these [container images](https://hub.docker.com/):

|container|tags|
|---------|----|
|amazon|all|
|alpine|all|
|debian|all|
|el|7, 8|
|fedora|all|
|opensuse|all|
|ubuntu|bionic|

The minimum version of Ansible required is 2.8 but tests have been done to:

- The previous version, on version lower.
- The current version.
- The development version.

Exceptions
----------

Some variarations of the build matrix do not work. These are the variations and reasons why the build won't work:

| variation                 | reason                 |
|---------------------------|------------------------|
| CentOS 8 | Packages openvas-cli and openvas-scanner are not available. |
| ArchLinux & Ansible 2.7 | New-style module did not handle its own exit |
| OpenSUSE Leap | atomic-release Signature verification failed |

Included version(s)
-------------------

This role [refers to a version](https://github.com/robertdebock/ansible-role-openvas/blob/master/vars/main.yml) released by Atomicorp. Check the released version(s) here:
- [openvas](https://updates.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/).

This version reference means a role may get outdated. Monthly tests occur to see if [bit-rot](https://en.wikipedia.org/wiki/Software_rot) occured. If you however find a problem, please create an issue, I'll get on it as soon as possible.
Testing
-------

[Unit tests](https://travis-ci.org/robertdebock/ansible-role-openvas) are done on every commit, pull request, release and periodically.

If you find issues, please register them in [GitHub](https://github.com/robertdebock/ansible-role-openvas/issues)

Testing is done using [Tox](https://tox.readthedocs.io/en/latest/) and [Molecule](https://github.com/ansible/molecule):

[Tox](https://tox.readthedocs.io/en/latest/) tests multiple ansible versions.
[Molecule](https://github.com/ansible/molecule) tests multiple distributions.

To test using the defaults (any installed ansible version, namespace: `robertdebock`, image: `fedora`, tag: `latest`):

```
molecule test

# Or select a specific image:
image=ubuntu molecule test
# Or select a specific image and a specific tag:
image="debian" tag="stable" tox
```

Or you can test multiple versions of Ansible, and select images:
Tox allows multiple versions of Ansible to be tested. To run the default (namespace: `robertdebock`, image: `fedora`, tag: `latest`) tests:

```
tox

# To run CentOS (namespace: `robertdebock`, tag: `latest`)
image="centos" tox
# Or customize more:
image="debian" tag="stable" tox
```

License
-------

Apache-2.0


Author Information
------------------

[Robert de Bock](https://robertdebock.nl/)
