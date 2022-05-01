# [obsproject](#obsproject)

Install obsproject on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-obsproject/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-obsproject/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-obsproject/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-obsproject)|[![quality](https://img.shields.io/ansible/quality/58829)](https://galaxy.ansible.com/buluma/obsproject)|[![downloads](https://img.shields.io/ansible/role/d/58829)](https://galaxy.ansible.com/buluma/obsproject)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-obsproject.svg)](https://github.com/buluma/ansible-role-obsproject/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-obsproject.svg)](https://github.com/buluma/ansible-role-obsproject/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-obsproject.svg)](https://github.com/buluma/ansible-role-obsproject/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.obsproject
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
    - role: buluma.epel
    - role: buluma.rpmfusion
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-obsproject/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.rpmfusion](https://galaxy.ansible.com/buluma/rpmfusion)|[![Build Status GitHub](https://github.com/buluma/ansible-role-rpmfusion/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-rpmfusion/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-rpmfusion/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-rpmfusion)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-obsproject/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-obsproject/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-obsproject/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
