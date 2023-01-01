# [atom](#atom)

Install atom on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-atom/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-atom/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-atom/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-atom)|[![quality](https://img.shields.io/ansible/quality/57873)](https://galaxy.ansible.com/buluma/atom)|[![downloads](https://img.shields.io/ansible/role/d/57873)](https://galaxy.ansible.com/buluma/atom)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-atom.svg)](https://github.com/buluma/ansible-role-atom/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-atom.svg)](https://github.com/buluma/ansible-role-atom/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-atom.svg)](https://github.com/buluma/ansible-role-atom/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.atom
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
# defaults file for atom

# Atom release.
atom_release: "1.60.0"

# GitLab version.
atom_version: "{{ _atom_version[atom_release] }}"

# What apm packages (https://atom.io/packages) to install.
atom_apm_packages:
  - linter
  - platformio-ide-terminal
  - teletype
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-atom/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-atom/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| amazonlinux:1 | Package: atom ... Requires: libsecret-1.so.0 ... and ... polkit |
| debian:bullseye | An error occurred during the test sequence action: 'idempotence'. Cleaning up. |
| centos:7 | /lib64/libstdc++.so.6: version `CXXABI_1.3.9' not found |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-atom/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-atom/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
