# [crun](#crun)

Ansible Role for crun Installation

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-crun/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-crun/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-crun/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-crun)|[![quality](https://img.shields.io/ansible/quality/60621)](https://galaxy.ansible.com/buluma/crun)|[![downloads](https://img.shields.io/ansible/role/d/60621)](https://galaxy.ansible.com/buluma/crun)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-crun.svg)](https://github.com/buluma/ansible-role-crun/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-crun.svg)](https://github.com/buluma/ansible-role-crun/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-crun.svg)](https://github.com/buluma/ansible-role-crun/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge | all
  hosts: all
  remote_user: root
  become: true
  gather_facts: true
  roles:
    - role: buluma.crun
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



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-crun/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-crun/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|jammy, focal, bionic|
|el|9, 8, 7|
|debian|all|
|fedora|36, 35|

The minimum version of Ansible required is 4.10, tests have been done to:

- The previous version.
- The current version.
- The development version.


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-crun/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-crun/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
