# [diskspace](#diskspace)

Check diskspace (or inodes) available, fail if too low.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-diskspace/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-diskspace/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-diskspace/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-diskspace)|[![quality](https://img.shields.io/ansible/quality/57815)](https://galaxy.ansible.com/buluma/diskspace)|[![downloads](https://img.shields.io/ansible/role/d/57815)](https://galaxy.ansible.com/buluma/diskspace)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-diskspace.svg)](https://github.com/buluma/ansible-role-diskspace/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-diskspace.svg)](https://github.com/buluma/ansible-role-diskspace/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-diskspace.svg)](https://github.com/buluma/ansible-role-diskspace/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.diskspace
      # In a container these mounts should be available.
      diskspace_mounts:
        - name: /etc/resolv.conf
          megabytes_available: 64
        - name: /etc/hostname
          gigabytes_available: 4
        - name: /etc/hosts
          inodes_available: 65536
          gigabytes_available: 1
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
# defaults file for diskspace

# You can pass a list of mountpoint and their minimum required space of inodes.
# diskspace_mounts:
#   - name: /
#     megabytes_available: 64
#   - name: /var
#     gigabytes_available: 4
#   - name: /home
#     inodes_available: 65536
diskspace_mounts: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-diskspace/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-diskspace/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-diskspace/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
