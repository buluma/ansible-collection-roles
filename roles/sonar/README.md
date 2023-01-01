# ansible-role-sonar-scanner

[![molecule](https://github.com/diodonfrost/ansible-role-sonar-scanner/workflows/molecule/badge.svg)](https://github.com/diodonfrost/ansible-role-sonar-scanner/actions)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-diodonfrost.sonar_scanner-660198.svg)](https://galaxy.ansible.com/diodonfrost/sonar_scanner)

This role provide a compliance for install sonar-scanner on your target host.

## Requirements

This role was developed using Ansible 2.5 Backwards compatibility is not guaranteed.
Use `ansible-galaxy install diodonfrost.sonar_scanner` to install the role on your system.

Supported platforms:

```yaml
- name: EL
  versions:
    - 8
    - 7
    - 6
- name: Fedora
  versions:
    - 31
    - 30
    - 29
    - 28
    - 27
    - 26
- name: Debian
  versions:
    - stretch
    - jessie
    - wheezy
    - squeeze
- name: Ubuntu
  versions:
    - disco
    - bionic
    - xenial
    - trusty
    - precise
- name: OracleLinux
  versions:
    - 7
    - 6
- name: Amazon
  versions:
    - 2017.12
    - 2016.03
    - 2013.09
- name: opensuse
  versions:
    - 42.3
    - 42.2
    - 42.1
    - 13.2
- name: SLES
  versions:
    - 15
- name: ArchLinux
  versions:
    - any
- name: Alpine
  versions:
    - any
- name: Gentoo
  versions:
    - stage3
- name: MacOSX
  versions:
    - 10.13
    - 10.12
    - 10.11
    - 10.10
- name: Windows
  versions:
    - 2016
    - 2012R2
    - 8.1
```

## Role Variables

This role has multiple variables. The defaults for all these variables are the following:

```yaml
---
# defaults file for ansible-role-sonar-scanner

# Define sonar-scanner version to install
# Possible values: https://api.github.com/repos/sonarsource/sonar-scanner-cli/tags
# Default: latest
sonar_scanner_version: latest

# Define directory  where to install Sonar Scanner client
# Default on Linux/Unix: /opt
sonar_scanner_directory: "{{ sonar_scanner_default_directory }}"

# Define where to install Sonar Scanner client binary
# Default on Linux/Unix: /usr/local/bin
# Default on Windows: %PROGRAMFILES%
sonar_scanner_path: "{{ sonar_scanner_default_path }}"
```

## Dependencies

None

## Example Playbook

This is a sample playbook file for deploying the Ansible Galaxy sonar-scanner role in a localhost and installing latest sonar-scanner version.

```yaml
---
- hosts: localhost
  become: true
  roles:
    - role: diodonfrost.sonar_scanner
```

This role can also install a specific version of sonar-scanner.

```yaml
---
- hosts: localhost
  become: true
  roles:
    - role: ansible-role-sonar_scanner
      vars:
        sonar-scanner_version: 3.3.0.1492

```

## Local Testing

This project uses [Molecule](http://molecule.readthedocs.io/) to aid in the
development and testing.

To develop or test you'll need to have installed the following:

* Linux (e.g. [Ubuntu](http://www.ubuntu.com/))
* [Docker](https://www.docker.com/)
* [Python](https://www.python.org/) (including python-pip)
* [Ansible](https://www.ansible.com/)
* [Molecule](http://molecule.readthedocs.io/)
* [Virtualbox](https://www.virtualbox.org/) (windows test only)
* [Vagrant](https://www.vagrantup.com/downloads.html) (windows test only)


### Testing with Docker

```shell
# Test ansible role with centos 8
molecule test

# Test ansible role with ubuntu 20.04
image=ansible-ubuntu:20.04 molecule test

# Test ansible role with alpine
image=ansible-alpine:latest molecule test

# Create centos 7 instance
image=ansible-centos:7 molecule create

# Apply role on centos 7 instance
image=ansible-centos:7 molecule converge

# Launch tests on centos 7 instance
image=ansible-centos:7 molecule verify
```

### Testing with Vagrant and Virtualbox

```shell
# Test ansible role with Windows
molecule test -s windows
```

## License

Apache 2

## Author Information

This role was created in 2019 by diodonfrost.
