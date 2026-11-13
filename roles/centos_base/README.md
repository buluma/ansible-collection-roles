# [Ansible role centos_base](#ansible-role-centos_base)

Basic CentOS Configuration

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-centos_base/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-centos_base/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-centos_base.svg)](https://github.com/buluma/ansible-role-centos_base/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-centos_base.svg)](https://github.com/buluma/ansible-role-centos_base/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-centos_base.svg)](https://github.com/buluma/ansible-role-centos_base/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/centos_base)](https://galaxy.ansible.com/ui/standalone/roles/buluma/centos_base/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-centos_base/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
# TODO: move this playbook to a different scenario
# Default scenario must work with default variable values
- name: Converge
  hosts: all
  vars:
    centos_base_utility_packages: true
    centos_base_enable_epel: true
    centos_base_vim_users: ["root"]
    centos_base_basic_vim_tweaks: true
    centos_base_firewalld_services: ["http"]
    centos_base_basic_packages: true
    centos_base_firewalld: true
    centos_base_debug_packages: true
    centos_base_security_packages: true
  pre_tasks:
    - name: intall Apache
      ansible.builtin.yum:
        name: httpd
    - name: start httpd
      ansible.builtin.systemd:
        name: httpd
        state: started
  roles:
    - role: buluma.centos_base
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-centos_base/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-centos_base/blob/master/defaults/main.yml):

```yaml
---
# defaults file for centos_base

centos_base_secure_sshd: false
centos_base_basic_vim_tweaks: false
centos_base_htop_configuration: false
centos_base_fail2ban_configuration: false
centos_base_selinux_packages: false
centos_base_firewalld_services: []
centos_base_utility_packages: false
centos_base_basic_packages: false
centos_base_debug_packages: false
centos_base_enable_epel: false
centos_base_lockprg: false
centos_base_security_packages: false
centos_base_firewalld: true
centos_base_development_packages: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-centos_base/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-centos_base/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-centos_base/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-centos_base/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
