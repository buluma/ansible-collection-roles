# [perforce](#perforce)

Install and Configure Perforce on your systems.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-perforce/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-perforce/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-perforce/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-perforce)|[![quality](https://img.shields.io/ansible/quality/59114)](https://galaxy.ansible.com/buluma/perforce)|[![downloads](https://img.shields.io/ansible/role/d/59114)](https://galaxy.ansible.com/buluma/perforce)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-perforce.svg)](https://github.com/buluma/ansible-role-perforce/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-perforce.svg)](https://github.com/buluma/ansible-role-perforce/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-perforce.svg)](https://github.com/buluma/ansible-role-perforce/pulls/)|

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
        name: buluma.perforce
      tags: buluma.perforce
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
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-perforce/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-perforce/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-perforce/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-perforce/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
