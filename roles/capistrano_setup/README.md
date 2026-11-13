# [Ansible role capistrano_setup](#ansible-role-capistrano_setup)

An ansible role for creating the default project structure when using Capistrano as your application deployment tool.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-capistrano_setup/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-capistrano_setup/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-capistrano_setup.svg)](https://github.com/buluma/ansible-role-capistrano_setup/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-capistrano_setup.svg)](https://github.com/buluma/ansible-role-capistrano_setup/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-capistrano_setup.svg)](https://github.com/buluma/ansible-role-capistrano_setup/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/capistrano_setup)](https://galaxy.ansible.com/ui/standalone/roles/buluma/capistrano_setup/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-capistrano_setup/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.capistrano_setup
      capistrano_setup_users:
        - name: capistrano project
          username: capistrano
          group: docker
          shell: ""
          comment: ""
          uid: 1750
          home: /
          createhomedir: false
          password: "{{ 'itsasecret' | password_hash('sha512') }}"
          update_password: on_create
          upload_key: false
          project_directory: "capistrano"
          placeholder: files/index.txt
      capistrano_setup_users_deleted:
        - name: buluma
          remove: false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-capistrano_setup/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-capistrano_setup/blob/master/defaults/main.yml):

```yaml
---
# defaults file for capistrano_setup

capistrano_setup_users:
# - username: docker // project username
#   name: buluma // name of the project or some extra information you want to put in the users comment field
#   group: docker
#   groups: 'docker, docker2' // list of groups the user belongs to
#   shell: '' // user shell
#   comment: ''
#   uid: 1750 // user id
#   home: / // path of the users home directory
#   createhomedir: false // indicate if you want to create the home directory
#   password: "{{ 'itsasecret' | password_hash('sha512') }}" // password for the project user
#   update_password: on_create
#   upload_key: false
#   project_directory: "capistrano" // possible subdirectory inside the users home directory for your project structure
#   placeholder: files/index.txt // placeholder file so you can have a dummy deployment when your project is not deployed yet
#   pub_key: // public key to use when deploying through capistrano
#   upload_key: // indicate if you want to upload the public key
capistrano_setup_users_deleted:
# - name: name of the user you want to remove
#   remove: false // indicate if you want to remove the users home directory
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-capistrano_setup/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-capistrano_setup/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-capistrano_setup/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-capistrano_setup/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
