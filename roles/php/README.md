# [Ansible role php](#ansible-role-php)

Install and configure php on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-php/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-php/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-php.svg)](https://github.com/buluma/ansible-role-php/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-php.svg)](https://github.com/buluma/ansible-role-php/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-php.svg)](https://github.com/buluma/ansible-role-php/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/php)](https://galaxy.ansible.com/ui/standalone/roles/buluma/php/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-php/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.httpd
    - role: buluma.php
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-php/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.python_pip
    - role: buluma.buildtools
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_facts['fqdn'] }}"
    - role: buluma.httpd
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-php/blob/master/defaults/main.yml):

```yaml
---
# defaults file for php

# The role discovers the ini location automatically, but can be overwritten.
# php_ini_location: /etc/php/7.4/apache/php.ini

# Alpine has both php5 and php7. Select the desired version here.
php_alpine_version: 7

# All the settings for PHP.
php_display_errors: false
php_startup_errors: false
php_error_reporting: false
php_html_errors: true
php_log_errors: true
php_max_input_time: 60
php_max_execution_time: 60
php_output_buffering: 4096
php_register_argc_argv: false
php_request_order: GP
php_session_gc_divisor: 1000
php_session_hash_bits_per_character: 5
php_short_open_tag: false
php_track_errors: false
php_variables_order: GPCS
php_engine: true
php_date_timezone: Africa/Nairobi
php_memory_limit: 128M
php_upload_max_filesize: 2M
php_post_max_size: 8M
# php_extensions:
#   - mcrypt.so
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-php/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.scl](https://galaxy.ansible.com/buluma/scl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-scl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-scl/actions)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- {'role': 'buluma.httpd'}

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-php/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-php/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-php/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
