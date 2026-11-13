# [Ansible role mysql](#ansible-role-mysql)

Install and configure mysql on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-mysql/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mysql.svg)](https://github.com/buluma/ansible-role-mysql/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mysql.svg)](https://github.com/buluma/ansible-role-mysql/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mysql.svg)](https://github.com/buluma/ansible-role-mysql/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/mysql)](https://galaxy.ansible.com/ui/standalone/roles/buluma/mysql/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-mysql/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.mysql
      mysql_port: 3307
      mysql_databases:
        - name: my_db
          encoding: utf8
          collation: utf8_bin
      mysql_users:
        - name: my_user
          password: my_pass
          priv: "my_db.*:ALL"
          update_password: on_create
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-mysql/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-mysql/blob/master/defaults/main.yml):

```yaml
---
# defaults file for mysql

# The address mysql should bind to.
mysql_bind_address: "127.0.0.1"

# The port to listen on.
mysql_port: 3306

# The password to set for the root user. Also stored in my.cnf
mysql_root_password: "s3Cur31t4."

# The buffer pool size.
mysql_innodb_buffer_pool_size: 1G

# The io capacity.
mysql_innodb_io_capacity: 4000

# You can set the mysql(d) options here.
# As this is a list, it's difficult to merge with another list.
# This means you'd have to redefine the entire list and append
# your options to it.
mysql_configuration_options:
  - option: bind-address
    section: mysqld
    value: "{{ mysql_bind_address }}"
  - option: port
    section: mysqld
    value: "{{ mysql_port }}"
  - option: socket
    section: mysqld
    value: "{{ mysql_socket }}"
  - section: mysqld
    option: innodb_buffer_pool_size
    value: "{{ mysql_innodb_buffer_pool_size }}"
  - section: mysqld
    option: innodb_io_capacity
    value: "{{ mysql_innodb_io_capacity }}"
  - section: mysqld
    option: log-bin-trust-function-creators
    value: "1"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mysql/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mysql/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-mysql/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-mysql/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
