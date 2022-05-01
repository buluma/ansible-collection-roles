# [f5ansible](#f5ansible)

Install F5 modules on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-f5ansible/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-f5ansible/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-f5ansible/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-f5ansible)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/f5ansible)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/f5ansible)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-f5ansible.svg)](https://github.com/buluma/ansible-role-f5ansible/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-f5ansible.svg)](https://github.com/buluma/ansible-role-f5ansible/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-f5ansible.svg)](https://github.com/buluma/ansible-role-f5ansible/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  vars:
    etherpad_port: 9002

  roles:
    - role: buluma.f5ansible
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



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-f5ansible/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-f5ansible/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|7, 8|
|ubuntu|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-f5ansible/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-f5ansible/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
