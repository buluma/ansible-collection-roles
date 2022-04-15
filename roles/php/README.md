# [php](#php)

Install and configure php on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-php/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php/-/commits/master)|[![quality](https://img.shields.io/ansible/quality/54977)](https://galaxy.ansible.com/buluma/php)|[![downloads](https://img.shields.io/ansible/role/d/54977)](https://galaxy.ansible.com/buluma/php)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-php.svg)](https://github.com/buluma/ansible-role-php/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.httpd
    - role: buluma.php
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.buildtools
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_fqdn }}"
    - role: buluma.httpd
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for php

# The role discovers the ini location automatically, but can be overwritten.
# php_ini_location: /etc/php/7.4/apache/php.ini

# Alpine has both php5 and php7. Select the desired version here.
php_alpine_version: 7

# All the settings for PHP.
php_display_errors: no
php_startup_errors: no
php_error_reporting: no
php_html_errors: yes
php_log_errors: yes
php_max_input_time: 60
php_max_execution_time: 60
php_output_buffering: 4096
php_register_argc_argv: no
php_request_order: GP
php_session_gc_divisor: 1000
php_session_hash_bits_per_character: 5
php_short_open_tag: no
php_track_errors: no
php_variables_order: GPCS
php_engine: yes
php_date_timezone: Africa/Nairobi
php_memory_limit: 128M
php_upload_max_filesize: 2M
php_post_max_size: 8M
# php_extensions:
#   - mcrypt.so
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-php/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-httpd/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.scl](https://galaxy.ansible.com/buluma/buluma.scl)|[![Build Status GitHub](https://github.com/buluma/buluma.scl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/buluma.scl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/buluma.scl/badges/main/pipeline.svg)](https://gitlab.com/buluma/buluma.scl)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.httpd
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-php/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Alpine | ImportError: Error loading shared library /tmp/pip-build-env-zrX8Lu/lib/python2.7/site-packages/_cffi_backend.so: Operation not permitted |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-php/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
