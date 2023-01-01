# [zabbix_repository](#zabbix_repository)

Install and configure zabbix_repository on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-zabbix_repository/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-zabbix_repository/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-zabbix_repository/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-zabbix_repository)|[![quality](https://img.shields.io/ansible/quality/57967)](https://galaxy.ansible.com/buluma/zabbix_repository)|[![downloads](https://img.shields.io/ansible/role/d/57967)](https://galaxy.ansible.com/buluma/zabbix_repository)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-zabbix_repository.svg)](https://github.com/buluma/ansible-role-zabbix_repository/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-zabbix_repository.svg)](https://github.com/buluma/ansible-role-zabbix_repository/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-zabbix_repository.svg)](https://github.com/buluma/ansible-role-zabbix_repository/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.zabbix_repository
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
    - role: buluma.ca_certificates
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for zabbix_repository

# The`"zabbix_version_major` are two numerical values, sparated by a period.
zabbix_repository_version_major: "5.4"

# The `zabbix_version_minor` is a single numerical value.
zabbix_repository_version_minor: 1
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-zabbix_repository/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-zabbix_repository/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|bullseye|
|opensuse|all|
|ubuntu|focal, bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Alpine | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Archlinux | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Fedora | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Ubuntu rolling | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| amazonlinux | Zabbix has [limited OS support](https://www.zabbix.com/download) |

## [Included version(s)](#included-versions)

This role [refers to a version](https://github.com/robertdebock/ansible-role-zabbix/blob/main/defaults/main.yml) released by Zabbix. Check the released version(s) here:
- [Zabbix](https://www.zabbix.com/download).

This version reference means a role may get outdated. Monthly tests occur to see if [bit-rot](https://en.wikipedia.org/wiki/Software_rot) occured. If you however find a problem, please create an issue, I'll get on it as soon as possible.

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-zabbix_repository/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-zabbix_repository/blob/main/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
