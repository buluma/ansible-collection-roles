# [podman](#podman)

Install and configure Podman on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-podman/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-podman/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-podman/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-podman)|[![quality](https://img.shields.io/ansible/quality/58938)](https://galaxy.ansible.com/buluma/podman)|[![downloads](https://img.shields.io/ansible/role/d/58938)](https://galaxy.ansible.com/buluma/podman)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-podman.svg)](https://github.com/buluma/ansible-role-podman/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-podman.svg)](https://github.com/buluma/ansible-role-podman/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-podman.svg)](https://github.com/buluma/ansible-role-podman/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.podman
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for podman

# You can modify the `storage.conf` file using this list.
# podman_storage:
#   - option: driver
#     value: overlay
#     section: storage
podman_storage: []

# You can start docker as a specific user other than "root".
# podman_user: my_user
podman_user: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-podman/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- {'role': 'buluma.bootstrap'}
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-podman/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|debian|bullseye|
|el|all|
|fedora|35, 36|
|opensuse|all|
|ubuntu|jammy|

The minimum version of Ansible required is 2.12, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Debian:bookworm | No package matching 'podman' is available |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-podman/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-podman/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
