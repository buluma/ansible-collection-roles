# [mysql](#mysql)

Install and configure mysql on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|[![quality](https://img.shields.io/ansible/quality/57921)](https://galaxy.ansible.com/buluma/mysql)|[![downloads](https://img.shields.io/ansible/role/d/57921)](https://galaxy.ansible.com/buluma/mysql)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mysql.svg)](https://github.com/buluma/ansible-role-mysql/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.mysql
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

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for mysql

# The address mysql should bind to.
mysql_bind_address: "127.0.0.1"

# The password to set for the root user. Also stored in my.cnf
mysql_root_password: "s3Cur31t4."

# The buffer pool size.
mysql_innodb_buffer_pool_size: 1G

# The io capacity.
mysql_innodb_io_capacity: 4000
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mysql/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mysql/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|bullseye|
|el|8|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Alpine | The PyMySQL (Python 2.7 and Python 3.X) or MySQL-python (Python 2.X) module is required. |
| amazonlinux:1 | /etc/init.d/mysqld: line 16: /etc/sysconfig/network: No such file or directory |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-mysql/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
