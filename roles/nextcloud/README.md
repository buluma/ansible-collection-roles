# [nextcloud](#nextcloud)

Install and configure Nextcloud on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-nextcloud/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nextcloud/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nextcloud/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nextcloud)|[![quality](https://img.shields.io/ansible/quality/50634)](https://galaxy.ansible.com/buluma/nextcloud)|[![downloads](https://img.shields.io/ansible/role/d/50634)](https://galaxy.ansible.com/buluma/nextcloud)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nextcloud.svg)](https://github.com/buluma/ansible-role-nextcloud/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.httpd
    - role: buluma.nextcloud
      nextcloud_apps:
        - name: richdocumentscode
      nextcloud_settings:
        - name: max_chunk_size
          section: files
          value: 0
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.core_dependencies
    - role: buluma.cron
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_fqdn }}"
    - role: buluma.selinux
    - role: buluma.httpd
    - role: buluma.redis

- name: continue prepare with facts
  hosts: all
  become: yes
  gather_facts: yes

  pre_tasks:
    - name: include remi
      ansible.builtin.include_role:
        name: buluma.remi
      when:
        - ansible_distribution != "Fedora"
      vars:
        remi_enabled_repositories:
          - php74

  roles:
    - role: buluma.php
      php_memory_limit: 512M
      php_upload_max_filesize: 8G
      php_post_max_size: 8G
    - role: buluma.php_fpm
    - role: buluma.mysql
      mysql_databases:
        - name: nextcloud
          encoding: utf8
          collation: utf8_bin
      mysql_users:
        - name: nextcloud
          password: N3x4Cl0ud
          priv: "nextcloud.*:ALL"
```

Also see a [full explanation and example](https://buluma.nl/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for nextcloud

# The version of nextcloud to install.
nextcloud_version: "23.0.0"

# The domain under which this server will be available. For example:
# "localhost" or "nextcloud.example.com". Does not include protocol identifier,
# (https://) or directories. (/nextcloud)
nextcloud_domain_url: "{{ ansible_default_ipv4.address | default(ansible_all_ipv4_addresses[0] ) }}"

# Database connection details.
nextcloud_database_name: nextcloud
nextcloud_database_user: nextcloud
nextcloud_database_pass: N3x4Cl0ud
nextcloud_database_host: "127.0.0.1"
nextcloud_admin_user: admin
nextcloud_admin_pass: N3x4Cl0ud

# You can install applications into NextCloud.
# nextcloud_apps:
#   - name: richdocumentscode

# You can set parameters for nextcloud
# nextcloud_settings:
#   - name: max_chunk_size
#     section: files
#     value: 0

# You can install nextcloud on a location of your choice. Distribution specific
# destinations are set in `vars/main.yml`, which are looked-up here. Feel free
# to overwrite the destination to some destination you prefer. For example:
#
# nextcloud_destination: /opt
#
nextcloud_destination: "{{ _nextcloud_destination[ansible_distribution] | default(_nextcloud_destination['default'] ) }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nextcloud/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-httpd/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php)|
|[buluma.php_fpm](https://galaxy.ansible.com/buluma/php_fpm)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php_fpm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php_fpm/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php_fpm/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php_fpm)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.redis](https://galaxy.ansible.com/buluma/redis)|[![Build Status GitHub](https://github.com/buluma/ansible-role-redis/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-redis/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-redis/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-redis)|
|[buluma.remi](https://galaxy.ansible.com/buluma/remi)|[![Build Status GitHub](https://github.com/buluma/ansible-role-remi/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-remi/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-remi/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-remi)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-selinux/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.nl/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nextcloud/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|bullseye|
|el|8|
|fedora|all|
|opensuse|all|
|ubuntu|focal|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| fedora:32 | nothing provides libzip(x86-64) >= 1.7.3 needed by php-pecl-zip-1.19.1-1.fc32.remi.7.4.x86_64 |
| fedora:rawhide | dependent role "remi" does not support fedora:rawhide. |
| debian:bullseye | Package 'php-dom' (and 'php-posix') has no installation candidate |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nextcloud/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.nl/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
