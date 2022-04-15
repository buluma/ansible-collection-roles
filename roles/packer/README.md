# [packer](#packer)

Packer for Linux

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-packer/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-packer/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-packer/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-packer)|[![quality](https://img.shields.io/ansible/quality/58650)](https://galaxy.ansible.com/buluma/packer)|[![downloads](https://img.shields.io/ansible/role/d/58650)](https://galaxy.ansible.com/buluma/packer)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-packer.svg)](https://github.com/buluma/ansible-role-packer/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-packer.svg)](https://github.com/buluma/ansible-role-packer/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-packer.svg)](https://github.com/buluma/ansible-role-packer/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - role: buluma.packer
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
    - role: buluma.ca_certificates
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
packer_version: "1.0.0"
packer_arch: "amd64"
packer_bin_path: /usr/local/bin
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-packer/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-packer/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.0, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-packer/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
