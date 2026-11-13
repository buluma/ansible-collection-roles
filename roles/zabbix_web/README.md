# [Ansible role zabbix_web](#ansible-role-zabbix_web)

Install and configure zabbix_web on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-zabbix_web/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-zabbix_web/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-zabbix_web.svg)](https://github.com/buluma/ansible-role-zabbix_web/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-zabbix_web.svg)](https://github.com/buluma/ansible-role-zabbix_web/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-zabbix_web.svg)](https://github.com/buluma/ansible-role-zabbix_web/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/zabbix_web)](https://galaxy.ansible.com/ui/standalone/roles/buluma/zabbix_web/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-zabbix_web/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role: buluma.zabbix_web
      zabbix_web_groups:
        - name: Linux servers
      zabbix_web_hosts:
        - description: Example server 1 description
          groups:
            - Linux servers
          interface_dns: server1.example.com
          interface_ip: 192.168.127.127
          link_templates:
            - Template OS Linux by Zabbix agent
          name: Example server 1
          visible_name: Example server 1 name
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-zabbix_web/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.selinux
    - role: robertdebock.container_docs
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.php
    - role: buluma.httpd
    - role: buluma.ca_certificates
    - role: buluma.zabbix_repository
    - role: buluma.core_dependencies
    - role: buluma.mysql

  tasks:
    - name: Create zabbix database
      ansible.mysql.mysql_db:
        login_user: root
        login_password: "{{ mysql_root_password }}"
        name: zabbix
        state: present

    - name: Create zabbix database user
      ansible.mysql.mysql_user:
        login_user: root
        login_password: "{{ mysql_root_password }}"
        name: zabbix
        password: zabbix
        priv: "zabbix.*:ALL"
        state: present

# buluma.zabbix_server imports the zabbix schema via a handler flushed
# during its own role execution, before this file's first play ever
# reaches its tasks: block -- so it needs its own play here, run after
# the database and user already exist above.
- name: Prepare zabbix_server
  hosts: all
  become: true
  gather_facts: false

  roles:
    - role: buluma.zabbix_server
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-zabbix_web/blob/master/defaults/main.yml):

```yaml
---
zabbix_web_database_name: zabbix
zabbix_web_database_pass: zabbix
zabbix_web_database_user: zabbix
zabbix_web_mysql_connection: socket
zabbix_web_password: zabbix
zabbix_web_server: "{{ ansible_facts['fqdn'] }}"
zabbix_web_server_name: zabbix
zabbix_web_server_port: 10051
zabbix_web_username: Admin
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-zabbix_web/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[robertdebock.container_docs](https://galaxy.ansible.com/buluma/robertdebock.container_docs)|[![Build Status GitHub](https://github.com/buluma/robertdebock.container_docs/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/robertdebock.container_docs/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|
|[buluma.zabbix_repository](https://galaxy.ansible.com/buluma/zabbix_repository)|[![Build Status GitHub](https://github.com/buluma/ansible-role-zabbix_repository/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-zabbix_repository/actions)|
|[buluma.zabbix_server](https://galaxy.ansible.com/buluma/zabbix_server)|[![Build Status GitHub](https://github.com/buluma/ansible-role-zabbix_server/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-zabbix_server/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-zabbix_web/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-zabbix_web/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-zabbix_web/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
