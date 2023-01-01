# [cloud_init](#cloud_init)

Install Cloud Init

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-cloud_init/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cloud_init/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-cloud_init/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cloud_init)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/cloud_init)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/cloud_init)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-cloud_init.svg)](https://github.com/buluma/ansible-role-cloud_init/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-cloud_init.svg)](https://github.com/buluma/ansible-role-cloud_init/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-cloud_init.svg)](https://github.com/buluma/ansible-role-cloud_init/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.clould_init
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for cloud_init
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-cloud_init/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-cloud_init/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|fedora|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-cloud_init/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-cloud_init/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
