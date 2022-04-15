# [moodle](#moodle)

Install and configure moodle on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-moodle/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-moodle/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-moodle/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-moodle)|[![quality](https://img.shields.io/ansible/quality/55981)](https://galaxy.ansible.com/buluma/moodle)|[![downloads](https://img.shields.io/ansible/role/d/55981)](https://galaxy.ansible.com/buluma/moodle)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-moodle.svg)](https://github.com/buluma/ansible-role-moodle/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.moodle
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
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.mysql
      mysql_databases:
        - name: moodle
          encoding: utf8mb4
          collation: utf8mb4_unicode_ci
      mysql_users:
        - name: moodle
          password: moodle
          priv: "moodle.*:ALL"
    - role: buluma.python_pip
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_fqdn }}"
    - role: buluma.php
    - role: buluma.selinux
    - role: buluma.httpd
      httpd_vhosts:
        - name: moodle
          servername: moodle.example.com
    - role: buluma.cron
    - role: buluma.core_dependencies
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for moodle

# The version of moodle to install.
moodle_version: 310

# A path where to save the data.
moodle_data_directory: /opt/moodledata

# The permissions of the created directories.
moodle_directory_mode: "0750"

# Details to connect to the database.
moodle_database_type: mysqli
moodle_database_hostname: localhost
moodle_database_name: moodle
moodle_database_username: moodle
moodle_database_password: moodle
moodle_database_prefix: ""

# The URL where to serve content.
moodle_wwwroot: "https://{{ ansible_default_ipv4.address }}/moodle"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-moodle/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-httpd/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-selinux/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-moodle/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|latest|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-moodle/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
