# [wordpress](#wordpress)

Install WordPress with webserver (Nginx or Apache2)

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-wordpress/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-wordpress/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-wordpress/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-wordpress)|[![quality](https://img.shields.io/ansible/quality/59815)](https://galaxy.ansible.com/buluma/wordpress)|[![downloads](https://img.shields.io/ansible/role/d/59815)](https://galaxy.ansible.com/buluma/wordpress)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-wordpress.svg)](https://github.com/buluma/ansible-role-wordpress/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-wordpress.svg)](https://github.com/buluma/ansible-role-wordpress/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-wordpress.svg)](https://github.com/buluma/ansible-role-wordpress/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- hosts: all
  vars:
    ansible_python_interpreter: /usr/bin/python3
    wp_version: 6.0.1
    wp_mysql_db: 'database_name_here'
    wp_mysql_user: 'username_here'
    wp_mysql_password: 'password_here'
    wp_webserver: nginx
    wp_sitename: localhost
    wp_admin_email: 'admin@example.com'
    wp_install_dir: "/var/www/{{ wp_sitename }}"
  roles:
    - buluma.wordpress
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
wp_version: 6.0.1
wp_install_dir: '/var/www/html'
wp_db_name: "{{ wp_mysql_db }}"
wp_db_user: "{{ wp_mysql_user }}"
wp_db_password: "{{ wp_mysql_password }}"
wp_db_host: 'localhost'
wp_db_charset: 'utf8'
wp_db_collate: ''
wp_table_prefix: 'wp_'
wp_debug: false
wp_admin_email: 'admin@example.com'
wp_webserver: nginx
site_name: "{{ wp_sitename }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-wordpress/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-wordpress/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-wordpress/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-wordpress/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
