# [apt_autostart](#apt_autostart)

Enable or disable automatic starting of services upon installation of packages.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-apt_autostart/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apt_autostart/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-apt_autostart/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apt_autostart)|[![quality](https://img.shields.io/ansible/quality/58347)](https://galaxy.ansible.com/buluma/apt_autostart)|[![downloads](https://img.shields.io/ansible/role/d/58347)](https://galaxy.ansible.com/buluma/apt_autostart)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-apt_autostart.svg)](https://github.com/buluma/ansible-role-apt_autostart/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-apt_autostart.svg)](https://github.com/buluma/ansible-role-apt_autostart/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-apt_autostart.svg)](https://github.com/buluma/ansible-role-apt_autostart/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.apt_autostart
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
# defaults file for apt_autostart

# Should services be managed when installing software using apt?
apt_autostart_state: disabled
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-apt_autostart/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-apt_autostart/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-apt_autostart/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-apt_autostart/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
