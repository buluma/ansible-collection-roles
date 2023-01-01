# [centos_base](#centos_base)

Basic CentOS Configuration

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-centos_base/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-centos_base/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-centos_base/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-centos_base)|[![quality](https://img.shields.io/ansible/quality/59067)](https://galaxy.ansible.com/buluma/centos_base)|[![downloads](https://img.shields.io/ansible/role/d/59067)](https://galaxy.ansible.com/buluma/centos_base)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-centos_base.svg)](https://github.com/buluma/ansible-role-centos_base/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-centos_base.svg)](https://github.com/buluma/ansible-role-centos_base/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-centos_base.svg)](https://github.com/buluma/ansible-role-centos_base/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
# TODO: move this playbook to a different scenario
# Default scenario must work with default variable values
- name: Converge
  hosts: all
  vars:
    - centos_base_utility_packages: true
    - centos_base_enable_epel: true
    - centos_base_vim_users: ['root']
    - centos_base_basic_vim_tweaks: true
    - centos_base_firewalld_services: ['http']
    - centos_base_basic_packages: true
    - centos_base_firewalld: true
    - centos_base_debug_packages: true
    - centos_base_security_packages: true
  pre_tasks:
    - name: intall Apache
      ansible.builtin.yum:
        name: httpd
    - name: start httpd
      ansible.builtin.systemd:
        name: httpd
        state: started
  roles:
    - role: buluma.centos_base
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for centos_base

centos_base_secure_sshd: false
centos_base_basic_vim_tweaks: false
centos_base_htop_configuration: false
centos_base_fail2ban_configuration: false
centos_base_selinux_packages: false
centos_base_firewalld_services: []
centos_base_nagios_packages: false
centos_base_utility_packages: false
centos_base_basic_packages: false
centos_base_debug_packages: false
centos_base_enable_epel: false
centos_base_lockprg: false
centos_base_security_packages: false
centos_base_firewalld: true
centos_base_development_packages: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-centos_base/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-centos_base/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8, 7|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-centos_base/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-centos_base/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
