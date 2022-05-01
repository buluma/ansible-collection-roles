# [daemonize](#daemonize)

Install and configure daemonize on your systems.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-daemonize/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-daemonize/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-daemonize/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-daemonize)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/daemonize)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/daemonize)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-daemonize.svg)](https://github.com/buluma/ansible-role-daemonize/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-daemonize.svg)](https://github.com/buluma/ansible-role-daemonize/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-daemonize.svg)](https://github.com/buluma/ansible-role-daemonize/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.daemonize"
      ansible.builtin.include_role:
        name: "buluma.daemonize"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for daemonize

workspace: /root

daemonize_version: 1.7.7
daemonize_install_path: "/usr"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-daemonize/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-daemonize/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|fedora|all|
|ubuntu|all|
|el|all|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-daemonize/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-daemonize/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
