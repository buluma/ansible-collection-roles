# [Ansible role mozilla_syncserver](#ansible-role-mozilla_syncserver)

A deployment role for Mozilla's Firefox Sync server.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-mozilla_syncserver/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mozilla_syncserver.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mozilla_syncserver.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mozilla_syncserver.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/mozilla_syncserver)](https://galaxy.ansible.com/ui/standalone/roles/buluma/mozilla_syncserver/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: Include ansible-mozilla-syncserver
      ansible.builtin.include_role:
        name: buluma.mozilla_syncserver
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/master/molecule/default/prepare.yml):

```yaml
- name: Prepare
  hosts: all
  pre_tasks:
  - name: Install sudo if missing
    ansible.builtin.raw: '{{ ansible_pkg_mgr | default(''dnf'') }} install -y sudo'
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

    become: false
    changed_when: false
    failed_when: false
  - name: Update the apt-cache, if necessary
    ansible.builtin.apt:
      cache_valid_time: 86400
      update_cache: true
    when: ansible_facts['os_family'] == 'Debian'
  roles:
  - buluma.setuptools
  - buluma.docker_ce
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/master/defaults/main.yml):

```yaml
---
mozilla_syncserver_additional_volumes: []
mozilla_syncserver_container_labels: []
mozilla_syncserver_docker_version: latest
mozilla_syncserver_environment_variables:
  PORT: "{{ mozilla_syncserver_port }}"
  SYNCSERVER_BATCH_UPLOAD_ENABLED: "true"
  SYNCSERVER_FORCE_WSGI_ENVIRON: "false"
  SYNCSERVER_PUBLIC_URL: http://localhost:{{ mozilla_syncserver_port }}
  SYNCSERVER_SECRET: <PUT YOUR SECRET KEY HERE>
  SYNCSERVER_SQLURI: sqlite:////data/syncserver.db
mozilla_syncserver_network_name: ""
mozilla_syncserver_port: "5000"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.setuptools](https://galaxy.ansible.com/buluma/setuptools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-setuptools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-setuptools/actions)|
|[buluma.docker_ce](https://galaxy.ansible.com/buluma/docker_ce)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker_ce/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker_ce/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mozilla_syncserver/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-mozilla_syncserver/issues).

## [License](#license)

[MIT](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
