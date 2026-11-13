# [Ansible role update_pip_packages](#ansible-role-update_pip_packages)

Find and update pip packages.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-update_pip_packages/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-update_pip_packages/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-update_pip_packages.svg)](https://github.com/buluma/ansible-role-update_pip_packages/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-update_pip_packages.svg)](https://github.com/buluma/ansible-role-update_pip_packages/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-update_pip_packages.svg)](https://github.com/buluma/ansible-role-update_pip_packages/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/update_pip_packages)](https://galaxy.ansible.com/ui/standalone/roles/buluma/update_pip_packages/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-update_pip_packages/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: converge
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
    - role: buluma.update_pip_packages
      update_pip_package_ignore:
        - libcomps
        - PyGObject
        - pygobject
        - pyxdg
        - resolvelib
        - dbus-python
        - setuptools
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-update_pip_packages/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.buildtools
    - role: buluma.python_pip
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-update_pip_packages/blob/master/defaults/main.yml):

```yaml
---
# defaults file for update_pip_packages

# A list of pip executables that will be use to get the packages.
# Either full path, or just name name of the executable.
# This role "discovers" pip and pip3 installations, but if you have a specific
# pip executalbe, you can add items to this list.
update_pip_packages_clients: []

# You can indicate to ignore a list of packages. Packages listed here will not be updated.
# update_pip_package_ignore:
#   - some_pip_package
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-update_pip_packages/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-update_pip_packages/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-update_pip_packages/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-update_pip_packages/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
