zabbix_web
=========

<img src="https://docs.ansible.com/ansible-tower/3.2.4/html_ja/installandreference/_static/images/logo_invert.png" width="10%" height="10%" alt="Ansible logo" align="right"/>
<a href="https://travis-ci.org/robertdebock/ansible-role-zabbix_web"> <img src="https://travis-ci.org/robertdebock/ansible-role-zabbix_web.svg?branch=master" alt="Build status"/></a> <img src="https://img.shields.io/ansible/role/d/57968"/> <img src="https://img.shields.io/ansible/quality/57968"/>

Install and configure zabbix_web on your system.

Example Playbook
----------------

This example is taken from `molecule/resources/playbook.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: robertdebock.zabbix_web
      # You can provision Zabbix groups.
      # Most options map directly to the documentation:
      # https://docs.ansible.com/ansible/latest/modules/zabbix_group_module.html
      zabbix_web_groups:
        - name: Linux servers
      # Add hosts to Zabbix.
      # Most options map directly to the documentation:
      # https://docs.ansible.com/ansible/latest/modules/zabbix_host_module.html
      zabbix_web_hosts:
        - name: Example server 1
          interface_ip: "192.168.127.127"
          interface_dns: server1.example.com
          visible_name: Example server 1 name
          description: Example server 1 description
          groups:
            - Linux servers
          link_templates:
            - Template OS Linux by Zabbix agent
```

The machine you are running this on, may need to be prepared, I use this playbook to ensure everything is in place to let the role work.
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.selinux
    - role: robertdebock.container_docs
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_fqdn }}"
    - role: buluma.mysql
      mysql_databases:
        - name: zabbix
          encoding: utf8
          collation: utf8_bin
      mysql_users:
        - name: zabbix
          password: zabbix
          priv: "zabbix.*:ALL"
    - role: buluma.php
    - role: buluma.httpd
    - role: buluma.ca_certificates
    - role: buluma.zabbix_repository
    - role: buluma.core_dependencies
    - role: buluma.zabbix_server
```


Also see a [full explanation and example](https://robertdebock.nl/how-to-use-these-roles.html) on how to use these roles.

Role Variables
--------------

These variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for zabbix_web

# How to connect to the mysql database, either `socket` or `network`.
zabbix_web_mysql_connection: socket

# Details to connect to the database.
zabbix_web_database_name: zabbix
zabbix_web_database_user: zabbix
zabbix_web_database_pass: zabbix

# When `zabbix_web_mysql_connection` is set to `network` this role needs
# these extra setting.
# zabbix_web_database_host: localhost
# zabbix_web_database_port: 3306

# Details to connect to Zabbix.
zabbix_web_server: "{{ ansible_fqdn }}"
zabbix_web_server_port: 10051
zabbix_web_server_name: zabbix

# Details to connect to the Zabbix API.
zabbix_web_username: Admin
zabbix_web_password: zabbix
zabbix_web_validate_certs: no
```

Requirements
------------

- Access to a repository containing packages, likely on the internet.
- A recent version of Ansible. (Tests run on the current, previous and next release of Ansible.)

The following roles can be installed to ensure all requirements are met, using `ansible-galaxy install -r requirements.yml`:

```yaml
---
roles:
  - name: buluma.bootstrap
  - name: buluma.buildtools
  - name: robertdebock.container_docs
  - name: buluma.ca_certificates
  - name: buluma.core_dependencies
  - name: buluma.epel
  - name: buluma.httpd
  - name: buluma.mysql
  - name: buluma.openssl
  - name: buluma.php
  - name: buluma.python_pip
  - name: buluma.selinux
  - name: buluma.zabbix_repository
  - name: buluma.zabbix_server
collections:
  - name: community.zabbix
  - name: ansible.posix
  - name: community.crypto
  - name: community.mysql

```

Context
-------

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://robertdebock.nl/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/robertdebock/drawings/artifacts/zabbix_web.png "Dependency")


Compatibility
-------------

This role has been tested on these [container images](https://hub.docker.com/):

|container|tag|allow_failures|
|---------|---|--------------|
||latest|no|

This role has been tested on these Ansible versions:

- 
- 
- 

Exceptions
----------

Some variarations of the build matrix do not work. These are the variations and reasons why the build won't work:

| variation                 | reason                 |
|---------------------------|------------------------|
| Alpine | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| amazonlinux | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Archlinux | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| CentOS 7 | Zabbix (5) requires php 7, not available on CentOS 7. |
| Debian | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Fedora | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| openSUSE | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Ubuntu rolling | Zabbix has [limited OS support](https://www.zabbix.com/download). |



Testing
-------

[Unit tests](https://travis-ci.org/robertdebock/ansible-role-zabbix_web) are done on every commit, pull request, release and periodically.

If you find issues, please register them in [GitHub](https://github.com/robertdebock/ansible-role-zabbix_web/issues)

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

Modules
-------

This role uses the following modules:
```yaml
---
- ansible.builtin.assert
- ansible.builtin.import_tasks
- ansible.builtin.meta
- ansible.builtin.package
- ansible.builtin.pip
- ansible.builtin.service
- ansible.builtin.template
- ansible.posix.seboolean
- community.zabbix.zabbix_group
- community.zabbix.zabbix_host
```

License
-------

Apache-2.0


Author Information
------------------

[Michael Buluma](https://robertdebock.nl/)
