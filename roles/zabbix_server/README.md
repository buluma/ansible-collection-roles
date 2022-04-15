# [zabbix_server](#zabbix_server)

Install and configure zabbix_server on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-zabbix_server/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-zabbix_server/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-zabbix_server/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-zabbix_server)|[![quality](https://img.shields.io/ansible/quality/57973)](https://galaxy.ansible.com/buluma/zabbix_server)|[![downloads](https://img.shields.io/ansible/role/d/57973)](https://galaxy.ansible.com/buluma/zabbix_server)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-zabbix_server.svg)](https://github.com/buluma/ansible-role-zabbix_server/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.zabbix_server
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
    - role: buluma.selinux
    - role: robertdebock.container_docs
    - role: buluma.mysql
      mysql_databases:
        - name: zabbix
          encoding: utf8
          collation: utf8_bin
      mysql_users:
        - name: zabbix
          password: zabbix
          priv: "zabbix.*:ALL"
    - role: buluma.ca_certificates
    - role: buluma.zabbix_repository
    - role: buluma.core_dependencies
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for zabbix_server

# The details to connect to the database.
zabbix_server_database_name: zabbix
zabbix_server_database_user: zabbix
zabbix_server_database_password: zabbix
zabbix_server_database_host: localhost
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-zabbix_server/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[robertdebock.container_docs](https://galaxy.ansible.com/robertdebock/container_docs)|[![Build Status GitHub](https://github.com/robertdebock/ansible-role-container_docs/workflows/Ansible%20Molecule/badge.svg)](https://github.com/robertdebock/ansible-role-container_docs/actions)|[![Build Status GitLab ](https://gitlab.com/robertdebock/ansible-role-container_docs/badges/master/pipeline.svg)](https://gitlab.com/buluma/robertdebock/ansible-role-container_docs)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-selinux/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|
|[buluma.zabbix_repository](https://galaxy.ansible.com/buluma/zabbix_repository)|[![Build Status GitHub](https://github.com/buluma/ansible-role-zabbix_repository/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-zabbix_repository/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-zabbix_repository/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-zabbix_repository)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-zabbix_server/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|bullseye|
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
| Alpine | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| amazonlinux | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Archlinux | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| CentOS 8 | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Debian | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Fedora | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| openSUSE | Zabbix has [limited OS support](https://www.zabbix.com/download). |
| Ubuntu rolling | Zabbix has [limited OS support](https://www.zabbix.com/download). |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-zabbix_server/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
