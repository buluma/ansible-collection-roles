# [Ansible role repo_epel](#ansible-role-repo_epel)

EPEL repository for RHEL/CentOS.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-repo_epel/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-repo_epel/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-repo_epel.svg)](https://github.com/buluma/ansible-role-repo_epel/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-repo_epel.svg)](https://github.com/buluma/ansible-role-repo_epel/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-repo_epel.svg)](https://github.com/buluma/ansible-role-repo_epel/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/repo_epel)](https://galaxy.ansible.com/ui/standalone/roles/buluma/repo_epel/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-repo_epel/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Find EXTERNALLY-MANAGED files
      ansible.builtin.find:
        paths: /usr/lib
        patterns: "EXTERNALLY-MANAGED"
        recurse: true
      register: externally_managed_files

    - name: Remove EXTERNALLY-MANAGED files
      ansible.builtin.file:
        path: "{{ item.path }}"
        state: absent
      loop: "{{ externally_managed_files.files }}"

  roles:
    - role: buluma.repo_epel
    - role: buluma.bootstrap
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-repo_epel/blob/master/molecule/default/prepare.yml):

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
      ansible.builtin.lineinfile:
        path: /etc/sudoers
        state: present
        regexp: '^%wheel'
        line: '%wheel ALL=(ALL) NOPASSWD: ALL'
        validate: 'visudo -cf %s'
      become: true

  roles:
    - role: buluma.bootstrap
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-repo_epel/blob/master/defaults/main.yml):

```yaml
---
epel_repo_url: "https://dl.fedoraproject.org/pub/epel/epel-release-latest-{{ ansible_facts['distribution_major_version'] }}.noarch.rpm"
epel_repo_gpg_key_url: "https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-{{ ansible_facts['distribution_major_version'] }}"
epel_repofile_path: "/etc/yum.repos.d/epel.repo"
epel_repo_disable: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-repo_epel/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-repo_epel/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-repo_epel/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-repo_epel/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
