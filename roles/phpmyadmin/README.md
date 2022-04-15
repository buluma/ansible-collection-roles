# [phpmyadmin](#phpmyadmin)

phpMyAdmin installation for Linux

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-phpmyadmin/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-phpmyadmin/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-phpmyadmin/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-phpmyadmin)|[![quality](https://img.shields.io/ansible/quality/58484)](https://galaxy.ansible.com/buluma/phpmyadmin)|[![downloads](https://img.shields.io/ansible/role/d/58484)](https://galaxy.ansible.com/buluma/phpmyadmin)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-phpmyadmin.svg)](https://github.com/buluma/ansible-role-phpmyadmin/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-phpmyadmin.svg)](https://github.com/buluma/ansible-role-phpmyadmin/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr/buluma/ansible-role-phpmyadmin.svg)](https://github.com/buluma/ansible-role-phpmyadmin/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    php_version: "7.3"
    phpmyadmin_enablerepo: "remi,remi-php73"

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - role: geerlingguy.repo-remi  # TODO: Rebuild
      when: ansible_os_family == 'RedHat'
    - role: buluma.apache
    - role: buluma.mysql
    - role: buluma.php_versions
    - role: buluma.php
    - role: geerlingguy.php-mysql  # TODO: Rebuild
    - role: geerlingguy.phpmyadmin  # TODO: Rebuild

  post_tasks:
    - name: Ensure phpMyAdmin is running.
      uri:
        url: "http://127.0.0.1/phpmyadmin/"
        status_code: 200
      register: result
      until: result.status == 200
      retries: 60
      delay: 1
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Pass in a comma-separated list of repos to use (e.g. "remi,epel"). Used only
# for RHEL/CentOS.
phpmyadmin_enablerepo: epel

# Override if needed. This is set platform-specific in the vars dir if not set.
# phpmyadmin_config_file: /etc/phpmyadmin/config.inc.php
phpmyadmin_mysql_host: localhost
phpmyadmin_mysql_port: ""
phpmyadmin_mysql_socket: ""
phpmyadmin_mysql_connect_type: tcp
phpmyadmin_mysql_user: root
phpmyadmin_mysql_password: "{{ mysql_root_password }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-phpmyadmin/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[geerlingguy.repo-remi](https://galaxy.ansible.com/buluma/geerlingguy.repo-remi)|[![Build Status GitHub](https://github.com/buluma/geerlingguy.repo-remi/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/geerlingguy.repo-remi/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/geerlingguy.repo-remi/badges/master/pipeline.svg)](https://gitlab.com/buluma/geerlingguy.repo-remi)|
|[buluma.apache](https://galaxy.ansible.com/buluma/apache)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apache/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apache)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.php_versions](https://galaxy.ansible.com/buluma/php_versions)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php_versions/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php_versions/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php_versions/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php_versions)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php)|
|[geerlingguy.php-mysql](https://galaxy.ansible.com/buluma/geerlingguy.php-mysql)|[![Build Status GitHub](https://github.com/buluma/geerlingguy.php-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/geerlingguy.php-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/geerlingguy.php-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/geerlingguy.php-mysql)|
|[geerlingguy.phpmyadmin](https://galaxy.ansible.com/buluma/geerlingguy.phpmyadmin)|[![Build Status GitHub](https://github.com/buluma/geerlingguy.phpmyadmin/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/geerlingguy.phpmyadmin/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/geerlingguy.phpmyadmin/badges/master/pipeline.svg)](https://gitlab.com/buluma/geerlingguy.phpmyadmin)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.apache
- buluma.mysql
- geerlingguy.php-mysql
- buluma.php
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-phpmyadmin/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-phpmyadmin/issues)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
