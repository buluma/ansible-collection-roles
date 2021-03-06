# [filesystem](#filesystem)

Make filesystems.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-filesystem/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-filesystem/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-filesystem/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-filesystem)|[![quality](https://img.shields.io/ansible/quality/57857)](https://galaxy.ansible.com/buluma/filesystem)|[![downloads](https://img.shields.io/ansible/role/d/57857)](https://galaxy.ansible.com/buluma/filesystem)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-filesystem.svg)](https://github.com/buluma/ansible-role-filesystem/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-filesystem.svg)](https://github.com/buluma/ansible-role-filesystem/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-filesystem.svg)](https://github.com/buluma/ansible-role-filesystem/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.filesystem
      filesystem_list:
        - dev: disk_1
          fstype: ext4
        - dev: disk_2
          fstype: ext3
          opts: -cc
        - dev: disk_3
          state: absent
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
    - name: make disk image
      command: truncate -s 16M "{{ item }}"
      args:
        creates: "{{ item }}"
      loop:
        - disk_1
        - disk_2
        - disk_3
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for filesystem

# If not specified in the `filesystem_list`, use this filesytem type.
filesytem_default_filesystem: ext4

# A list of filesytems to manage.
filesystem_list: []

# For example:
# filesystem_list:
#   - dev: /dev/sdb1
#     fstype: ext4
#   - dev: /dev/sdb2
#     fstype: ext3
#     opts: -cc
#   - dev: /dev/sdb3
#     state: absent
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-filesystem/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-filesystem/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|all|
|debian|all|
|el|8|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-filesystem/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-filesystem/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
