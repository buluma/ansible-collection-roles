# [Ansible role varnish](#ansible-role-varnish)

Varnish for Linux.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-varnish/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-varnish/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-varnish.svg)](https://github.com/buluma/ansible-role-varnish/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-varnish.svg)](https://github.com/buluma/ansible-role-varnish/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-varnish.svg)](https://github.com/buluma/ansible-role-varnish/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/varnish)](https://galaxy.ansible.com/ui/standalone/roles/buluma/varnish/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-varnish/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

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
    - role: buluma.systemd
      systemd_default_target: multi-user.target
    - role: buluma.httpd
    - role: buluma.varnish
  vars:
    varnish_apt_use_packagecloud: false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-varnish/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-varnish/blob/master/defaults/main.yml):

```yaml
---
varnish_admin_listen_host: "127.0.0.1"
varnish_admin_listen_port: "6082"
varnish_apt_repo: deb https://packagecloud.io/varnishcache/{{ varnish_packagecloud_repo }}/packages/{{ ansible_facts['distribution'] | lower }}/ {{
  ansible_facts['distribution_release'] }} main
varnish_apt_use_packagecloud: true
varnish_config_path: /etc/varnish
varnish_default_backend_host: "127.0.0.1"
varnish_default_backend_port: "8080"
varnish_default_vcl_template_path: default.vcl.j2
varnish_enabled_services:
  - varnish
varnish_limit_nofile: 131072
varnish_listen_address: ""
varnish_listen_port: "80"
varnish_modules_package_name: ""
varnish_package_name: varnish
varnish_packagecloud_repo_yum_repository_priority: "1"
varnish_pidfile: /run/varnishd.pid
varnish_secret: 14bac2e6-1e34-4770-8078-974373b76c90
varnish_storage: file,/var/lib/varnish/varnish_storage.bin,256M
varnish_use_default_vcl: true
varnish_version: "9.1"
varnish_yum_repo_baseurl: "{{ varnish_repository_base_url }}/el/{{ ansible_facts['distribution_major_version'] | int }}/$basearch"
varnishd_extra_options: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-varnish/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.systemd](https://galaxy.ansible.com/buluma/systemd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-systemd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-systemd/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-varnish/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-varnish/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-varnish/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)

The default repository line now targets Varnish 9.1 (current upstream release 9.1.0). Varnish 9+ uses `https://packages.varnish-software.com/varnish`; the former Packagecloud `varnish91` repository does not exist. `varnish_repository_base_url` and `varnish_repository_key_url` select the current upstream base/key for 9+ and retain Packagecloud URLs for explicit older-line overrides. As before, `varnish_version` selects a repository line, not an exact patch package version. Supported platforms and VCL/VMOD compatibility must be reviewed before upgrading existing servers.
