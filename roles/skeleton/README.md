# [skeleton](#skeleton)

Ansible role .skeleton

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-skeleton/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-skeleton/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-skeleton/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-skeleton)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/skeleton)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/skeleton)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-skeleton.svg)](https://github.com/buluma/ansible-role-skeleton/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-skeleton.svg)](https://github.com/buluma/ansible-role-skeleton/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-skeleton.svg)](https://github.com/buluma/ansible-role-skeleton/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.skeleton
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
    - role: buluma.systemd
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ansible-role-skeleton
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-skeleton/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-skeleton/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|7, 8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-skeleton/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-skeleton/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
