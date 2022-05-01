# [ssh_keys](#ssh_keys)

Manage ssh public key authentication (public / private / authorized keys and known hosts) in Debian-like systems

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ssh_keys/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ssh_keys/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ssh_keys/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ssh_keys)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/ssh_keys)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/ssh_keys)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ssh_keys.svg)](https://github.com/buluma/ansible-role-ssh_keys/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ssh_keys.svg)](https://github.com/buluma/ansible-role-ssh_keys/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ssh_keys.svg)](https://github.com/buluma/ansible-role-ssh_keys/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes
  roles:
    - buluma.ssh_keys
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: true
  tasks: []
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
# defaults file
---
ssh_keys_generate_keys: []
ssh_keys_generate_keys_become: false
ssh_keys_private_keys: []
ssh_keys_public_keys: []
ssh_keys_authorized_keys: []
ssh_keys_known_hosts: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ssh_keys/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ssh_keys/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.9.0, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ssh_keys/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-ssh_keys/blob/master/CHANGELOG.md)

## [License](#license)

MIT

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
