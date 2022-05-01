# [ara_api](#ara_api)

Install and configure ara api on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ara_api/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ara_api/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ara_api/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ara_api)|[![quality](https://img.shields.io/ansible/quality/58814)](https://galaxy.ansible.com/buluma/ara_api)|[![downloads](https://img.shields.io/ansible/role/d/58814)](https://galaxy.ansible.com/buluma/ara_api)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ara_api.svg)](https://github.com/buluma/ansible-role-ara_api/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ara_api.svg)](https://github.com/buluma/ansible-role-ara_api/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ara_api.svg)](https://github.com/buluma/ansible-role-ara_api/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.ara_api
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ara_api/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ara_api/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|fedora|all|
|ubuntu|bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | Could not find a version that satisfies the requirement Django>=2.1.5 |
| centos:7 | No matching distribution found for Django>=2.1.5 |
| amazonlinux:1 | No package matching 'python3-pip' |
| amazonlinux | No module named pkg_resources |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ara_api/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-ara_api/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
