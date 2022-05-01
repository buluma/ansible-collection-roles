# [icingaweb2](#icingaweb2)

Installs and configures Icinga Web 2 on Rhel, Debian and Ubuntu

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-icingaweb2/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-icingaweb2/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-icingaweb2/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-icingaweb2)|[![quality](https://img.shields.io/ansible/quality/58626)](https://galaxy.ansible.com/buluma/icingaweb2)|[![downloads](https://img.shields.io/ansible/role/d/58626)](https://galaxy.ansible.com/buluma/icingaweb2)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-icingaweb2.svg)](https://github.com/buluma/ansible-role-icingaweb2/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-icingaweb2.svg)](https://github.com/buluma/ansible-role-icingaweb2/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-icingaweb2.svg)](https://github.com/buluma/ansible-role-icingaweb2/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.icingaweb2
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare container
  hosts: all
  gather_facts: true

  roles:
    - role: buluma.bootstrap
    - role: buluma.ca_certificates

  tasks:
    - name: apt update
      ansible.builtin.apt:
        name: "{{ item }}"
        update_cache: yes
        state: present
      loop:
        - gnupg
      when: ( ansible_os_family == "Debian" and ansible_distribution == "Ubuntu" and ansible_distribution_major_version == "18" ) or
            ( ansible_os_family == "Debian" and ansible_distribution_major_version == "10" )
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Installation Params
icingaweb2_manage_package: yes
icingaweb2_manage_centos_scl: yes
icingaweb2_manage_repository: yes
icingaweb2_manage_roles: yes
icingaweb2_manage_director: no
icingaweb2_config_dir: /etc/icingaweb2
icingaweb2_modules_path: /usr/share/icingaweb2/modules
icingaweb2_modules_config: "{{ icingaweb2_config_dir }}/modules"
icingaweb2_group: icingaweb2

# Director
icingaweb2_director_home: /var/lib/icingadirector
icingaweb2_manage_director_service: no
# icingaweb2_roles:
#   administrators:
#     users: icinga
#     permissions: "*"
#     groups: Administrators


icingaweb2_resources:
  icinga_ido:
    type: db
    db: mysql
    host: localhost
    dbname: icinga
    username: icinga
    password: icinga
    use_ssl: 0
    charset: utf8
  icingaweb_db:
    type: db
    db: mysql
    host: localhost
    dbname: icingaweb
    username: icingaweb
    password: icingaweb
    use_ssl: 0

icingaweb2_groups:
  icingaweb2:
    backend: db
    resource: icingaweb_db

icingaweb2_authentication:
  icingaweb2:
    backend: db
    resource: icingaweb_db

icingaweb2_config:
  global:
    show_stacktraces: 1
    show_application_state_messages: 1
    config_backend: ini
    module_path: /usr/share/icingaweb2/modules
  logging:
    log: syslog
    level: ERROR
    application: icingaweb2
    facility: user
  themes:
    default: Icinga

icingaweb2_monitoring_config:
  security:
    protected_customvars: "*pw*,*pass*,community"
icingaweb2_monitoring_backends:
  icinga:
    type: ido
    resource: icinga_ido
icingaweb2_monitoring_commandtransports:
  icinga2:
    transport: api
    host: localhost
    port: 5665
    username: root
    password: root

icingaweb2_modules:
  - name: monitoring
  # - name: director
  #   git_url: https://github.com/Icinga/icingaweb2-module-director.git
  #   version: v1.7.2
  # - name: ipl
  #   git_url: https://github.com/Icinga/icingaweb2-module-ipl.git
  #   version: v0.5.0
  # - name: reactbundle
  #   git_url: https://github.com/Icinga/icingaweb2-module-reactbundle.git
  #   version: v0.7.0
  # - name: incubator
  #   git_url: https://github.com/Icinga/icingaweb2-module-incubator.git
  #   version: v0.5.0
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-icingaweb2/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-icingaweb2/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.8, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-icingaweb2/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-icingaweb2/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
