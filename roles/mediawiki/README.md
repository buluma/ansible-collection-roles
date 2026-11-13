# [Ansible role mediawiki](#ansible-role-mediawiki)

Install and configure mediawiki on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-mediawiki/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-mediawiki/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mediawiki.svg)](https://github.com/buluma/ansible-role-mediawiki/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mediawiki.svg)](https://github.com/buluma/ansible-role-mediawiki/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mediawiki.svg)](https://github.com/buluma/ansible-role-mediawiki/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/mediawiki)](https://galaxy.ansible.com/ui/standalone/roles/buluma/mediawiki/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-mediawiki/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  pre_tasks:
    - apt: update_cache=yes cache_valid_time=600
      changed_when: false
      name: Update apt cache.
      when: ansible_facts['os_family'] == 'Debian'
    - ansible.builtin.stat:
        path: /usr/lib/python3.11/EXTERNALLY-MANAGED
      name: Check if python3.11 EXTERNALLY-MANAGED file exists
      register: externally_managed_file_py311
    - ansible.builtin.command:
        cmd: mv /usr/lib/python3.11/EXTERNALLY-MANAGED
          /usr/lib/python3.11/EXTERNALLY-MANAGED.old
      args:
        creates: /usr/lib/python3.11/EXTERNALLY-MANAGED.old
      name: Rename python3.11 EXTERNALLY-MANAGED file if it exists
      when: externally_managed_file_py311.stat.exists
    - ansible.builtin.stat:
        path: /usr/lib/python3.12/EXTERNALLY-MANAGED
      name: Check if python3.12 EXTERNALLY-MANAGED file exists
      register: externally_managed_file_py312
    - ansible.builtin.command:
        cmd: mv /usr/lib/python3.12/EXTERNALLY-MANAGED
          /usr/lib/python3.12/EXTERNALLY-MANAGED.old
      args:
        creates: /usr/lib/python3.12/EXTERNALLY-MANAGED.old
      name: Rename python3.12 EXTERNALLY-MANAGED file if it exists
      when: externally_managed_file_py312.stat.exists
  roles:
    - mediawiki_destination: /opt
      role: buluma.mediawiki
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-mediawiki/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.core_dependencies
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.buildtools
    - role: buluma.httpd
    - role: buluma.php
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-mediawiki/blob/master/defaults/main.yml):

```yaml
---
mediawiki_destination: "{{ _mediawiki_destination[ansible_facts['distribution']] | default(_mediawiki_destination['default']) }}"
mediawiki_major: 1
mediawiki_minor: 46
mediawiki_release: 2
mediawiki_version: "{{ mediawiki_major }}.{{ mediawiki_minor }}.{{ mediawiki_release }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mediawiki/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- {'role': 'buluma.httpd'}

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mediawiki/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-mediawiki/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-mediawiki/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)

The default targets MediaWiki 1.46.2. Existing wikis using the previous 1.37.1 default must first upgrade to MediaWiki 1.39 or 1.43 before upgrading to 1.46.2. Provision a supported PHP/database runtime and review extension compatibility before upgrading existing wikis. Updating role defaults does not migrate the wiki database or replace an externally managed PHP runtime.
