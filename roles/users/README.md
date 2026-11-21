# [Ansible role users](#ansible-role-users)

The purpose of this role is to add users and groups on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-users/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-users/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-users.svg)](https://github.com/buluma/ansible-role-users/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-users.svg)](https://github.com/buluma/ansible-role-users/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-users.svg)](https://github.com/buluma/ansible-role-users/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/users)](https://galaxy.ansible.com/ui/standalone/roles/buluma/users/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-users/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role: buluma.users
      users:
        - cron_allow: true
          name: root
          unauthorized_keys:
            - ssh-rsa XYZYX54321
        - authorized_keys:
            - ssh-rsa ABC123
          comment: Michael Buluma
          cron_allow: true
          expires: -1
          group: bulumadb
          groups:
            - users
          name: bulumadb
          password_validity_days: 9
          sudo_options: "ALL=(ALL) NOPASSWD: ALL"
          uid: 1024
        - authorized_keys:
            - ssh-rsa ABC123
          comment: Michael Buluma with dots in username
          cron_allow: true
          expires: -1
          group: bulumadb
          groups:
            - users
          name: buluma.m.o
          password_validity_days: 9
          sudo_options: ALL=(ALL) ALL
          uid: 1025
        - name: notuser
          state: absent
        - manage_ssh_key: true
          name: keyuser
        - copy_private_key: true
          manage_ssh_key: true
          name: privkeyuser
        - authorized_keys:
            - ssh-rsa ABC1234
            - ssh-rsa ABC12345
          name: multiplekeys
        - name: passuser
          password: $6$mysecretsalt$qJbapG68nyRab3gxvKWPUcs2g3t0oMHSHMnSKecYNpSi3CuZm.GbBqXO8BE6EI6P1JUefhA0qvD7b5LSh./PU1
          update_password: on_create
        - authorized_keys:
            - https://raw.githubusercontent.com/shaanr/smdb/master/file.pub
          name: remotekey
        - name: systemuser
          system: true
        - name: multisudo
          sudo_options:
            - "ALL= NOPASSWD: /usr/bin/systemctl restart httpd"
            - "ALL= NOPASSWD: /usr/bin/systemctl start httpd"
            - "ALL= NOPASSWD: /usr/bin/systemctl stop httpd"
        - name: myprivkeyuser
          private_keys:
            - content: "{{ lookup('ansible.builtin.file', lookup('ansible.builtin.env', 'MOLECULE_SCENARIO_DIRECTORY') ~ '/ssh_keys/myprivkeyuser', rstrip=False) }}"
              name: id_rsa
      users_groups:
        - gid: 1024
          name: bulumadb
        - name: users
        - name: notgroup
          state: absent
        - name: systemgroup
          system: true
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-users/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-users/blob/master/defaults/main.yml):

```yaml
---
users_create_home: true
users_cron_allow: true
users_shell: /bin/bash
users_ssh_key_directory: ssh_keys
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-users/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-users/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.19, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-users/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-users/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
