# [transmission](#transmission)

Ansible Role for Transmission Installation

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-transmission/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-transmission/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-transmission/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-transmission)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/transmission)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/transmission)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-transmission.svg)](https://github.com/buluma/ansible-role-transmission/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-transmission.svg)](https://github.com/buluma/ansible-role-transmission/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-transmission.svg)](https://github.com/buluma/ansible-role-transmission/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---

- hosts: all
  remote_user: root
  become: true
  tasks:
    - name: include role
      ansible.builtin.include_role:
        name: buluma.transmission
      tags: buluma.transmission
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---

- hosts: all
  remote_user: root
  become: true
  gather_facts: false

  roles:
    - name: buluma.bootstrap
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-transmission/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-transmission/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|el|all|
|opensuse|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 4.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-transmission/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-transmission/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
