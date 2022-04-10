# [influxdb](#influxdb)

Install and configures InfluDB on Rhel, Debian and Ubuntu

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-influxdb/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-influxdb/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-influxdb/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-influxdb)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/influxdb)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/influxdb)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-influxdb.svg)](https://github.com/buluma/ansible-role-influxdb/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-influxdb.svg)](https://github.com/buluma/ansible-role-influxdb/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-influxdb.svg)](https://github.com/buluma/ansible-role-influxdb/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  vars:
    influxdb_admin_username: admin
    influxdb_admin_password: admin123
    influxdb_databases:
      - name: telegraf-metrics
        state: present
    influxdb_users:
      - name: telegraf
        password: telegraf
        grants:
          - database: telegraf-metrics
            privilege: "WRITE"
  roles:
    - role: buluma.influxdb
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare container
  hosts: all
  gather_facts: true
  tasks:
    - name: install python-pip on RHEL7
      yum:
        name: python-pip
        state: present
      when: ansible_os_family == "RedHat" and ansible_distribution_major_version == "7"

    - name: install python3-pip on RHEL8
      yum:
        name: python3
        state: present
      when: ansible_os_family == "RedHat" and ansible_distribution_major_version == "8"

    - name: apt install pip on Ubuntu
      apt:
        name: "{{ item }}"
        update_cache: yes
        state: present
      loop:
        - python3-pip
        - python3-setuptools
        - gnupg
      when: ( ansible_os_family == "Debian" and ansible_distribution == "Ubuntu" )

    - name: install pip on Debian
      apt:
        name: "{{ item }}"
        state: present
        update_cache: true
      loop:
        - gnupg
        - python-setuptools
        - python-pip
      when: ( ansible_os_family == "Debian" and ( ansible_distribution_major_version == "10" or ansible_distribution_major_version == "9" ))
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
influxdb_manage_repository: yes
influxdb_manage_package: yes
influxdb_config_dir: /etc/influxdb
influxdb_config_global:
    reporting-disabled: false
    bind-address: 127.0.0.1:8088
influxdb_config_graphite:
  - enabled: false
    tags:
      - region=us
      - zone=test
influxdb_config_collectd:
  - enabled: false
influxdb_config_udp:
  - enabled: false
influxdb_config_meta:
  dir: /var/lib/influxdb/meta
  retention-autocreate: true
  logging-enabled: true
influxdb_config_http:
  enabled: true
  https-enabled: false
  bind-address: 127.0.0.1:8086
  auth-enabled: true
  ping-auth-enabled: true
influxdb_config_data:
  dir: /var/lib/influxdb/data
  wal-dir: /var/lib/influxdb/wal
  series-id-set-cache-size: 100
influxdb_admin_username: admin
influxdb_admin_password: admin
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-influxdb/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-influxdb/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-influxdb/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
