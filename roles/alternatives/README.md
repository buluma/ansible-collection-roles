# [alternatives](#alternatives)

Set alternatives

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-alternatives/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-alternatives/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-alternatives/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-alternatives)|[![quality](https://img.shields.io/ansible/quality/57818)](https://galaxy.ansible.com/buluma/alternatives)|[![downloads](https://img.shields.io/ansible/role/d/57818)](https://galaxy.ansible.com/buluma/alternatives)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-alternatives.svg)](https://github.com/buluma/ansible-role-alternatives/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-alternatives.svg)](https://github.com/buluma/ansible-role-alternatives/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-alternatives.svg)](https://github.com/buluma/ansible-role-alternatives/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.alternatives
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

  tasks:
    - name: make a fake binary
      ansible.builtin.file:
        path: /bin/my_fake_binary
        state: touch
        mode: "0755"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for alternatives

# This is an example of how to use python3.7 on a system that has both
# python 2.7 and python 3.7.
# alternatives_list:
#   - name: python
#     link: /usr/bin/python2.7
#     path: /usr/bin/python
#   - name: python
#     link: /usr/bin/python3.7
#     path: /usr/bin/python

alternatives_list: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-alternatives/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-alternatives/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Archlinux | target not found: alternatives |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-alternatives/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-alternatives/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
