# [varnish](#varnish)

Varnish for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-varnish/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-varnish/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-varnish/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-varnish)|[![quality](https://img.shields.io/ansible/quality/54985)](https://galaxy.ansible.com/buluma/varnish)|[![downloads](https://img.shields.io/ansible/role/d/54985)](https://galaxy.ansible.com/buluma/varnish)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-varnish.svg)](https://github.com/buluma/ansible-role-varnish/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-varnish.svg)](https://github.com/buluma/ansible-role-varnish/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-varnish.svg)](https://github.com/buluma/ansible-role-varnish/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: buluma.varnish
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
    - role: buluma.systemd
    - role: buluma.httpd

  tasks:
    - name: update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    - name: ensure build dependencies are installed (RedHat 7+).
      ansible.builtin.yum:
        name:
          - logrotate
          - systemd-sysv
        state: present
      when:
        - ansible_os_family == 'RedHat'
        - ansible_distribution_major_version >= '7'

    - name: ensure build dependencies are installed (RedHat < 7).
      ansible.builtin.yum:
        name: logrotate
        state: present
      when:
        - ansible_os_family == 'RedHat'
        - ansible_distribution_major_version < '7'

    - name: ensure curl is installed.
      package: name=curl state=present
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
varnish_package_name: "varnish"
varnish_version: "7.1"

varnish_use_default_vcl: true
varnish_default_vcl_template_path: default.vcl.j2

varnish_default_backend_host: "127.0.0.1"
varnish_default_backend_port: "8080"

varnish_listen_address: ""
varnish_listen_port: "80"
varnish_secret: "14bac2e6-1e34-4770-8078-974373b76c90"
varnish_config_path: /etc/varnish
varnish_limit_nofile: 131072

varnish_admin_listen_host: "127.0.0.1"
varnish_admin_listen_port: "6082"

varnish_storage: "file,/var/lib/varnish/varnish_storage.bin,256M"
varnish_pidfile: /run/varnishd.pid

varnishd_extra_options: ""

varnish_enabled_services:
  - varnish

# Make sure Packagecloud repo is used on RHEL/CentOS.
varnish_packagecloud_repo_yum_repository_priority: "1"

# Only used on RedHat / CentOS.
varnish_yum_repo_baseurl: https://packagecloud.io/varnishcache/{{ varnish_packagecloud_repo }}/el/{{ ansible_distribution_major_version|int }}/$basearch

# Only used on Debian / Ubuntu.
varnish_apt_repo: deb https://packagecloud.io/varnishcache/{{ varnish_packagecloud_repo }}/{{ ansible_distribution | lower }}/ {{ ansible_distribution_release }} main

# Optionally define additional backends.
# varnish_backends:
#   apache:
#     host: 10.0.2.2
#     port: 80
#   nodejs:
#     host: 10.0.2.3
#     port: 80

# Optionally define vhosts pointed at different backends.
# varnish_vhosts:
#   example.com:
#     backend: apache
#   nodejs.example.com:
#     backend: nodejs
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-varnish/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.systemd](https://galaxy.ansible.com/buluma/systemd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-systemd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-systemd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-systemd/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-systemd)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-httpd/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-varnish/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|
|fedora|all|
|amazon|all|
|archlinux|all|

The minimum version of Ansible required is 2.5, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | Dependency not available: python_pip |
| archlinux | version `GLIBC_2.34' not found (required by /usr/lib/libpython3.10.so.1.0)
 |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-varnish/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-varnish/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
