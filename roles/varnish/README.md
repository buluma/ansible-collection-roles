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

  pre_tasks:
    - import_tasks: setup.yml

  roles:
    - role: buluma.varnish

  post_tasks:
    - name: Check the installed Varnish version.
      command: varnishd -V
      register: varnish_version_output
      failed_when: "varnish_version not in varnish_version_output.stderr"
      changed_when: false
      tags: ['skip_ansible_lint']

    - name: Verify Varnish is running on port 80.
      shell: 'curl -sI localhost:80 | grep -q "Via: .* varnish"'
      args:
        warn: false
      changed_when: false
      tags: ['skip_ansible_lint']
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
varnish_package_name: "varnish"
varnish_version: "6.4"

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


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-varnish/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.5, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-varnish/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
