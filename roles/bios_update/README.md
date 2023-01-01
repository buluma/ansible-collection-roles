# [bios_update](#bios_update)

Download, extract and write bootable USB image.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-bios_update/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bios_update/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-bios_update/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bios_update)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/bios_update)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/bios_update)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-bios_update.svg)](https://github.com/buluma/ansible-role-bios_update/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-bios_update.svg)](https://github.com/buluma/ansible-role-bios_update/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-bios_update.svg)](https://github.com/buluma/ansible-role-bios_update/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.bios_update"
      include_role:
        name: "buluma.bios_update"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for bios_update
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-bios_update/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-bios_update/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|jammy, focal, bionic|
|el|8, 7|
|opensuse|all|
|debian|bullseye|
|fedora|36, 35|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-bios_update/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-bios_update/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
