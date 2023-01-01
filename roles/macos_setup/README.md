# [macos_setup](#macos_setup)

Setup your macOS in quick simple steps using ansible.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-macos_setup/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-macos_setup/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-macos_setup/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-macos_setup)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/macos_setup)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/macos_setup)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-macos_setup.svg)](https://github.com/buluma/ansible-role-macos_setup/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-macos_setup.svg)](https://github.com/buluma/ansible-role-macos_setup/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-macos_setup.svg)](https://github.com/buluma/ansible-role-macos_setup/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: localhost
  become: true
  serial:
    - 1
    - 2
    - 25%
    - 50%

  roles:
    - role: buluma.macos_setup
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for macos_setup
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-macos_setup/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-macos_setup/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|fedora|all|
|macos|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-macos_setup/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-macos_setup/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
