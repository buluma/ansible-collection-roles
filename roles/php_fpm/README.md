# [php_fpm](#php_fpm)

The purpose of this role is to install and configure php_fpm on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-php_fpm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php_fpm/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-php_fpm/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php_fpm)|[![quality](https://img.shields.io/ansible/quality/57956)](https://galaxy.ansible.com/buluma/php_fpm)|[![downloads](https://img.shields.io/ansible/role/d/57956)](https://galaxy.ansible.com/buluma/php_fpm)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-php_fpm.svg)](https://github.com/buluma/ansible-role-php_fpm/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.php_fpm
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
    - role: buluma.epel
    - role: buluma.buildtools
    - role: buluma.python_pip
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
# defaults file for php_fpm

# The `php_fpm_listen` parameter can be an address:port combination or a path
# if you want to use a socket. For example: "127.0.0.1:9000"

php_fpm_listen: "{{ php_fpm_pid_directory }}/www.sock"

# When using a socket in `php_fpm_listen`, you can set the user and group.
# Sane defaults are set in `vars/main.yml`
php_fpm_listen_owner: "{{ php_fpm_owner }}"
php_fpm_listen_group: "{{ php_fpm_group }}"
php_fpm_listen_mode: "0666"

php_fpm_pm: dynamic
php_fpm_pm_max_children: 5
php_fpm_pm_start_servers: 2
php_fpm_pm_min_spare_servers: 1
php_fpm_pm_max_spare_servers: 3
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-php_fpm/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-selinux/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-httpd/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-php_fpm/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-php_fpm/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
