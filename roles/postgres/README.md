# [postgres](#postgres)

Install and configure postgres on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-postgres/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-postgres/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-postgres/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-postgres)|[![quality](https://img.shields.io/ansible/quality/57951)](https://galaxy.ansible.com/buluma/postgres)|[![downloads](https://img.shields.io/ansible/role/d/57951)](https://galaxy.ansible.com/buluma/postgres)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-postgres.svg)](https://github.com/buluma/ansible-role-postgres/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.postgres
      postgres_port: 6543
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for postgres

postgres_port: 5432
postgres_listen_addresses: "127.0.0.1"
postgres_unix_socket_directories: "{{ postgres_socket_directory }}"
postgres_max_wal_size: 1GB
postgres_min_wal_size: 80MB
postgres_log_timezone: UTC
postgres_datestyle: iso, ymd
postgres_timezone: UTC
postgres_default_text_search_config: pg_catalog.english

postgres_hba_entries:
  - type: local
    database: all
    user: all
    method: peer
  - type: host
    database: all
    user: all
    address: "127.0.0.1/32"
    method: ident
  - type: host
    database: all
    user: all
    address: "::1/128"
    method: ident
  - type: local
    database: replication
    user: all
    method: peer
  - type: host
    database: replication
    user: all
    address: "127.0.0.1/32"
    method: ident
  - type: host
    database: replication
    user: all
    address: "::1/128"
    method: ident
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-postgres/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-postgres/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|8|
|debian|all|
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
| EL | No package postgresql-server available |
| amazonlinux:1 | /etc/init.d/postgresql: line 37: /etc/sysconfig/network: No such file or directory |
| amazonlinux | Dependency (python_pip) no supported. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-postgres/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
