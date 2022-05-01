# [mount](#mount)

Configure mounts

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-mount/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mount/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-mount/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mount)|[![quality](https://img.shields.io/ansible/quality/57860)](https://galaxy.ansible.com/buluma/mount)|[![downloads](https://img.shields.io/ansible/role/d/57860)](https://galaxy.ansible.com/buluma/mount)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mount.svg)](https://github.com/buluma/ansible-role-mount/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mount.svg)](https://github.com/buluma/ansible-role-mount/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mount.svg)](https://github.com/buluma/ansible-role-mount/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.mount
      mount_requests:
        - path: /mnt/tmp
          src: /tmp
          opts: bind
          fstype: none
          mode: "1777"
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
# defaults file for mount

# The `mode`, `owner` and `group` can be set in the `mount_requests` list, but
# when not specified, these defaults are used.
mount_default_mode: "0750"
mount_default_owner: root
mount_default_group: root

# You can define mounts as variables. All parameters for the `mount` module are
# supported.

# mount_requests:
#   - path: /mnt/tmp
#     src: /tmp
#     opts: bind
#     fstype: none
#   - path: swap
#     src: /dev/data/swap
#     fstype: swap
#     opts: sw
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mount/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mount/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|debian|all|
|el|8|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-mount/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-mount/blob/main/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
