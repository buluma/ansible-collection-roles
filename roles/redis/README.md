# [redis](#redis)

Install and configure redis on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-redis/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-redis/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-redis/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-redis)|[![quality](https://img.shields.io/ansible/quality/54968)](https://galaxy.ansible.com/buluma/redis)|[![downloads](https://img.shields.io/ansible/role/d/54968)](https://galaxy.ansible.com/buluma/redis)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-redis.svg)](https://github.com/buluma/ansible-role-redis/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-redis.svg)](https://github.com/buluma/ansible-role-redis/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-redis.svg)](https://github.com/buluma/ansible-role-redis/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.redis
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
    - role: buluma.epel
    - role: buluma.apt_autostart
    - role: buluma.sysctl
      sysctl_items:
        - name: vm.overcommit_memory
          value: 1
    - role: robertdebock.grub
      grub_options:
        - option: transparent_hugepage
          value: never
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-redis/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.apt_autostart](https://galaxy.ansible.com/buluma/apt_autostart)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apt_autostart/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apt_autostart/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apt_autostart/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apt_autostart)|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.sysctl](https://galaxy.ansible.com/buluma/sysctl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-sysctl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sysctl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-sysctl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sysctl)|
|[robertdebock.grub](https://galaxy.ansible.com/buluma/robertdebock.grub)|[![Build Status GitHub](https://github.com/buluma/robertdebock.grub/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/robertdebock.grub/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/robertdebock.grub/badges/main/pipeline.svg)](https://gitlab.com/buluma/robertdebock.grub)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-redis/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-redis/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-redis/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
