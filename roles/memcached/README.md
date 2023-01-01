# [memcached](#memcached)

Install and configure Memcached for Linux

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-memcached/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-memcached/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-memcached/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-memcached)|[![quality](https://img.shields.io/ansible/quality/54984)](https://galaxy.ansible.com/buluma/memcached)|[![downloads](https://img.shields.io/ansible/role/d/54984)](https://galaxy.ansible.com/buluma/memcached)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-memcached.svg)](https://github.com/buluma/ansible-role-memcached/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-memcached.svg)](https://github.com/buluma/ansible-role-memcached/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-memcached.svg)](https://github.com/buluma/ansible-role-memcached/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - role: buluma.memcached
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
memcached_port: 11211
memcached_listen_ip: 127.0.0.1

memcached_memory_limit: 64
memcached_connections: 1024

memcached_log_file: /var/log/memcached.log
memcached_log_verbosity: ""

memcached_max_item_size: 1m

memcached_threads: 4
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-memcached/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-memcached/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|
|ubuntu|focal, jammy|
|debian|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-memcached/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-memcached/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
