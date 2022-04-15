# [roundcubemail](#roundcubemail)

Install and configure roundcubemail on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-roundcubemail/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-roundcubemail/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-roundcubemail/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-roundcubemail)|[![quality](https://img.shields.io/ansible/quality/58660)](https://galaxy.ansible.com/buluma/roundcubemail)|[![downloads](https://img.shields.io/ansible/role/d/58660)](https://galaxy.ansible.com/buluma/roundcubemail)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-roundcubemail.svg)](https://github.com/buluma/ansible-role-roundcubemail/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-roundcubemail.svg)](https://github.com/buluma/ansible-role-roundcubemail/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-roundcubemail.svg)](https://github.com/buluma/ansible-role-roundcubemail/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  vars_files:
    ../../vars/main.yml

  roles:
    - role: buluma.httpd
      httpd_vhosts:
        - name: docroot
          servername: roundcubemail.example.com
          documentroot: "{{ roundcubemail_install_directory }}"
    - role: buluma.roundcubemail
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
    - role: buluma.buildtools
    - role: buluma.python_pip
    - role: buluma.ca_certificates
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_fqdn }}"
    - role: buluma.selinux
    - role: buluma.httpd
    - role: buluma.php
      php_upload_max_filesize: 5M
      php_post_max_size: 6M
      php_date_timezone: Europe/Amsterdam
      php_extension:
        - mcrypt.so
    - role: buluma.mysql
      mysql_databases:
        - name: roundcube
      mysql_users:
        - name: roundcube
          password: roundcube
          priv: "roundcube.*:ALL"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for roundcubemail

roundcubemail_database_host: localhost
roundcubemail_database_user: roundcube
roundcubemail_database_password: roundcube
roundcubemail_database_name: roundcube

# A URL to get support.
roundcubemail_support_url: "{{ ansible_fqdn }}/support"

# A key to encrypt sensitive data.
roundcubemail_des_key: 964af56991531a805bd55085

# The spellchecker to use. Either: 'google', 'pspell', 'enchant' or 'atd'.
roundcubemail_spellcheck_engine: pspell
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-roundcubemail/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-httpd/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.reboot](https://galaxy.ansible.com/buluma/reboot)|[![Build Status GitHub](https://github.com/buluma/ansible-role-reboot/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-reboot/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-reboot/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-reboot)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-selinux/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.httpd
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-roundcubemail/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
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
| centos:8 | No package roundcubemail available. |
| amazonlinux:1 | No package matching 'python3-pip' found available, installed or updated |
| amazonlinux:latest | The error was: ImportError: No module named pkg_resources (openssl role) |
| alpine | failed to install mariadb py-mysqldb (mysql role) |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-roundcubemail/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
