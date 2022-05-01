# [postgresql_replication](#postgresql_replication)

Ansible role to deploy postgresql software with replication

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-postgresql_replication/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-postgresql_replication/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-postgresql_replication/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-postgresql_replication)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/postgresql_replication)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/postgresql_replication)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-postgresql_replication.svg)](https://github.com/buluma/ansible-role-postgresql_replication/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-postgresql_replication.svg)](https://github.com/buluma/ansible-role-postgresql_replication/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-postgresql_replication.svg)](https://github.com/buluma/ansible-role-postgresql_replication/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.postgresql_replication
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
    - role: buluma.enix
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for postgresql_replication

postgresql_replication__group: "postgresql"
postgresql_replication__group_master: "postgresql_master"
postgresql_replication__group_replicas: "postgresql_replicas"

postgresql_replication__user: "replicate"
postgresql_replication__password: "replicate"

postgresql_replication__waldir: "/var/lib/postgresql/wal-slave/"
postgresql_replication__walsenders: 3
postgresql_replication__walsegments: 64

# !!! set this to 'yesiwant' to bootstrap cluster
# postgresql_replication__bootstrap undefined

postgresql_replication__trigger_file: "/tmp/MasterNow"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-postgresql_replication/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[enix.postgresql](https://galaxy.ansible.com/buluma/enix.postgresql)|[![Build Status GitHub](https://github.com/buluma/enix.postgresql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/enix.postgresql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/enix.postgresql/badges/master/pipeline.svg)](https://gitlab.com/buluma/enix.postgresql)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.postgresql
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-postgresql_replication/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-postgresql_replication/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-postgresql_replication/blob/master/CHANGELOG.md)

## [License](#license)

license Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
