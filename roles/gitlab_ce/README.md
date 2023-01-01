# [gitlab_ce](#gitlab_ce)

Ansible Role for GitLab CE Installation.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-gitlab_ce/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-gitlab_ce/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-gitlab_ce/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-gitlab_ce)|[![quality](https://img.shields.io/ansible/quality/58932)](https://galaxy.ansible.com/buluma/gitlab_ce)|[![downloads](https://img.shields.io/ansible/role/d/58932)](https://galaxy.ansible.com/buluma/gitlab_ce)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-gitlab_ce.svg)](https://github.com/buluma/ansible-role-gitlab_ce/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-gitlab_ce.svg)](https://github.com/buluma/ansible-role-gitlab_ce/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-gitlab_ce.svg)](https://github.com/buluma/ansible-role-gitlab_ce/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- hosts: all
  remote_user: root
  become: true
  gather_facts: yes
  roles:
    - name: buluma.gitlab_ce
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- hosts: all
  remote_user: root
  become: true
  gather_facts: false
  tasks:
    - name: Redhat | subscription-manager register
      ansible.builtin.raw: |
        set -eu
        subscription-manager register \
          --username={{ lookup('env', 'REDHAT_USERNAME') }} \
          --password={{ lookup('env', 'REDHAT_PASSWORD') }} \
          --auto-attach
      changed_when: false
      failed_when: false

  roles:
    - name: buluma.bootstrap
    - name: buluma.common
    - name: buluma.timezone
    - name: buluma.setuptools
      when:
        - ansible_os_family != 'Ubuntu'
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---

# GitLab release.
gitlab_release: "14.9"

# GitLab version.
gitlab_version: "{{ _gitlab_version[gitlab_release] }}"

# GitLab external URL.
gitlab_external_url: "http://{{ ansible_default_ipv4.address }}"

# Set to approximately 1/4 of available RAM.
gitlab_postgresql_shared_buffers: "256MB"

# Disable Prometheus node_exporter inside Docker.
gitlab_node_exporter_enable: "true"

# Manage accounts with docker.
gitlab_manage_accounts_enable: "false"

# Explicitly disable init detection since we are running on a container.
gitlab_package_detect_init: "true"

# Attempt to modify kernel paramaters.
gitlab_package_modify_kernel_parameters: "true"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-gitlab_ce/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.timezone](https://galaxy.ansible.com/buluma/timezone)|[![Build Status GitHub](https://github.com/buluma/ansible-role-timezone/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-timezone/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-timezone/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-timezone)|
|[buluma.setuptools](https://galaxy.ansible.com/buluma/setuptools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-setuptools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-setuptools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-setuptools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-setuptools)|
|[buluma.common](https://galaxy.ansible.com/buluma/common)|[![Build Status GitHub](https://github.com/buluma/ansible-role-common/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-common/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-common/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-common)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-gitlab_ce/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|el|8|
|debian|bookworm|
|fedora|35, 36|
|opensuse|all|
|centos|all|
|oraclelinux|all|

The minimum version of Ansible required is 4.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| enterpriselinux:7 | Failed to import the required Python library (setuptools) on gitlabce-enterpriselinux-7's Python /usr/bin/python. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-gitlab_ce/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-gitlab_ce/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
