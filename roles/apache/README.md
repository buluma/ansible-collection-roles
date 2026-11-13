# [Ansible role apache](#ansible-role-apache)

Apache 2.x for Linux.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-apache/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-apache/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-apache.svg)](https://github.com/buluma/ansible-role-apache/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-apache.svg)](https://github.com/buluma/ansible-role-apache/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-apache.svg)](https://github.com/buluma/ansible-role-apache/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/apache)](https://galaxy.ansible.com/ui/standalone/roles/buluma/apache/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-apache/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    apache_listen_port_ssl: 443
    apache_create_vhosts: true
    apache_vhosts_filename: "vhosts.conf"
    apache_vhosts:
      - servername: "example.com"
        documentroot: "/var/www/vhosts/example_com"

  pre_tasks:
    - name: Update apt cache.
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 600
      when: ansible_facts['os_family'] == 'Debian'
      changed_when: false

  roles:
    - role: buluma.apache
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-apache/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-apache/blob/master/defaults/main.yml):

```yaml
---
apache_enablerepo: ""

apache_listen_ip: "*"
apache_listen_port: 80
apache_listen_port_ssl: 443

apache_create_vhosts: true
apache_vhosts_filename: "vhosts.conf"
apache_vhosts_template: "vhosts.conf.j2"

# On Debian/Ubuntu, a default virtualhost is included in Apache's configuration.
# Set this to `true` to remove that default.
apache_remove_default_vhost: false

apache_global_vhost_settings: |
  DirectoryIndex index.php index.html

apache_vhosts:
  # Additional properties:
  # 'serveradmin, serveralias, allow_override, options, extra_parameters'.
  - servername: "local.dev"
    documentroot: "/var/www/html"

apache_allow_override: "All"
apache_options: "-Indexes +FollowSymLinks"

apache_vhosts_ssl: []
# Additional properties:
# 'serveradmin, serveralias, allow_override, options, extra_parameters'.
# - servername: "local.dev",
#   documentroot: "/var/www/html",
#   certificate_file: "/path/to/certificate.crt",
#   certificate_key_file: "/path/to/certificate.key",
#   # Optional.
#   certificate_chain_file: "/path/to/certificate_chain.crt"

apache_ignore_missing_ssl_certificate: true

apache_ssl_protocol: "All -SSLv2 -SSLv3"
apache_ssl_cipher_suite: "AES256+EECDH:AES256+EDH"

# Only used on Debian/Ubuntu.
apache_mods_enabled:
  - rewrite.load
  - ssl.load
apache_mods_disabled: []
# Set initial apache state. Recommended values: `started` or `stopped`
apache_state: started

# Set initial apache service status. Recommended values: `true` or `false`
apache_enabled: true

# Set apache state when configuration changes are made. Recommended values:
# `restarted` or `reloaded`
apache_restart_state: restarted

# Apache package state; use `present` to make sure it's installed, or `latest`
# if you want to upgrade or switch versions using a new repo.
apache_packages_state: present
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-apache/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-apache/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-apache/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-apache/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
