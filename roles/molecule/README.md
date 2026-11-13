# [Ansible role molecule](#ansible-role-molecule)

Install Molecule on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-molecule/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-molecule/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-molecule.svg)](https://github.com/buluma/ansible-role-molecule/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-molecule.svg)](https://github.com/buluma/ansible-role-molecule/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-molecule.svg)](https://github.com/buluma/ansible-role-molecule/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/molecule)](https://galaxy.ansible.com/ui/standalone/roles/buluma/molecule/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-molecule/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_facts['os_family'] == 'Debian'
      changed_when: false

    - name: Check if python3.11 EXTERNALLY-MANAGED file exists
      ansible.builtin.stat:
        path: /usr/lib/python3.11/EXTERNALLY-MANAGED
      register: externally_managed_file_py311

    - name: Rename python3.11 EXTERNALLY-MANAGED file if it exists
      ansible.builtin.command:
        cmd: mv /usr/lib/python3.11/EXTERNALLY-MANAGED
          /usr/lib/python3.11/EXTERNALLY-MANAGED.old
      when: externally_managed_file_py311.stat.exists
      args:
        creates: /usr/lib/python3.11/EXTERNALLY-MANAGED.old

    - name: Check if python3.12 EXTERNALLY-MANAGED file exists
      ansible.builtin.stat:
        path: /usr/lib/python3.12/EXTERNALLY-MANAGED
      register: externally_managed_file_py312

    - name: Rename python3.12 EXTERNALLY-MANAGED file if it exists
      ansible.builtin.command:
        cmd: mv /usr/lib/python3.12/EXTERNALLY-MANAGED
          /usr/lib/python3.12/EXTERNALLY-MANAGED.old
      when: externally_managed_file_py312.stat.exists
      args:
        creates: /usr/lib/python3.12/EXTERNALLY-MANAGED.old

  roles:
    - role: buluma.molecule
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-molecule/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.buildtools
    - role: buluma.epel
  tasks:
    - name: Find EXTERNALLY-MANAGED files
      ansible.builtin.find:
        paths:
          - /usr/lib
          - /usr/local/lib
        patterns:
          - "EXTERNALLY-MANAGED"
        recurse: true
        file_type: file
      register: externally_managed_files
    - name: Rename EXTERNALLY-MANAGED files
      ansible.builtin.command:
        cmd: "mv {{ item.path }} {{ item.path }}.old"
      loop: "{{ externally_managed_files.files }}"
      loop_control:
        label: "{{ item.path }}"
      when: externally_managed_files.matched > 0
      args:
        creates: "{{ item.path }}.old"
      changed_when: true
    - name: Install python_pip role
      ansible.builtin.import_role:
        name: buluma.python_pip
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-molecule/blob/master/defaults/main.yml):

```yaml
---
# defaults file for molecule

# If you need to give extra options to pip, use `molecule_extra_args`. For
# example:
# molecule_extra_args: "--user"
molecule_extra_args: ""

# A list of plugins to install. (Can be empty.)
molecule_plugins:
  - molecule-plugins[docker]
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-molecule/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-molecule/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-molecule/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-molecule/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
