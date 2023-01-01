# [earlyoom](#earlyoom)

Install and configure Early Out Of Memory Killer on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-earlyoom/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-earlyoom/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-earlyoom/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-earlyoom)|[![quality](https://img.shields.io/ansible/quality/59162)](https://galaxy.ansible.com/buluma/earlyoom)|[![downloads](https://img.shields.io/ansible/role/d/59162)](https://galaxy.ansible.com/buluma/earlyoom)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-earlyoom.svg)](https://github.com/buluma/ansible-role-earlyoom/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-earlyoom.svg)](https://github.com/buluma/ansible-role-earlyoom/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-earlyoom.svg)](https://github.com/buluma/ansible-role-earlyoom/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.earlyoom
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for earlyoom

earlyoom_version: v1.7
earlyoom_clone_destination: /tmp/earlyoom
earlyoom_installation_destination: /usr/bin

earlyoom_minimum_memory_percent: 10
earlyoom_minimum_swap_percent: 5
earlyoom_memory_report_interval: 60  # in seconds
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-earlyoom/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-earlyoom/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-earlyoom/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-earlyoom/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
