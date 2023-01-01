# [mas](#mas)

Mac App Store CLI installation for macOS

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-mas/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mas/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-mas/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mas)|[![quality](https://img.shields.io/ansible/quality/55171)](https://galaxy.ansible.com/buluma/mas)|[![downloads](https://img.shields.io/ansible/role/d/55171)](https://galaxy.ansible.com/buluma/mas)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mas.svg)](https://github.com/buluma/ansible-role-mas/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mas.svg)](https://github.com/buluma/ansible-role-mas/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mas.svg)](https://github.com/buluma/ansible-role-mas/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.mas
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
mas_email: ""
mas_password: ""
mas_installed_app_ids: []  # Deprecated
mas_installed_apps:
  - {id: 425264550, name: "Blackmagic Disk Speed Test (3.0)"}
  - {id: 411643860, name: "DaisyDisk (4.3.2)"}
  - {id: 498486288, name: "Quick Resizer (1.9)"}
  - {id: 497799835, name: "Xcode (8.1)"}

mas_upgrade_all_apps: false
mas_signin_dialog: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mas/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mas/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|macos|all, any|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-mas/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-mas/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
