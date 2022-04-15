# [solr](#solr)

Apache Solr for Linux.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-solr/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-solr/actions)|[![pipeline status](https://gitlab.com/buluma/ansible-role-solr-v2/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-solr-v2/-/commits/main)|[![quality](https://img.shields.io/ansible/quality/54760)](https://galaxy.ansible.com/buluma/solr)|[![downloads](https://img.shields.io/ansible/role/d/54760)](https://galaxy.ansible.com/buluma/solr)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-solr.svg)](https://github.com/buluma/ansible-role-solr/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Set Java 8 package for RedHat.
      set_fact:
        java_packages:
          - java-1.8.0-openjdk
      when: ansible_os_family == "RedHat"

    - name: Set Java 8 package for Ubuntu.
      set_fact:
        java_packages:
          - openjdk-8-jdk
      when: ansible_os_family == "Ubuntu"

    - name: Set Java 11 package for Debian.
      set_fact:
        java_packages:
          - openjdk-11-jdk
      when: ansible_os_family == "Debian"

    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == "Debian"

    # See: http://unix.stackexchange.com/a/342469
    - name: Install dependencies (Debian).
      apt:
        name:
          - openjdk-11-jre-headless
          - ca-certificates-java
        state: present
      when: ansible_distribution == "Debian"

  roles:
    - role: buluma.java
    - role: buluma.solr
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
solr_workspace: /root

solr_create_user: true
solr_user: solr
solr_group: "{{ solr_user }}"

solr_version: "8.6.0"
solr_mirror: "https://archive.apache.org/dist"
solr_remove_cruft: false

solr_service_manage: true
solr_service_name: solr
solr_service_state: started

solr_install_dir: /opt
solr_install_path: "/opt/{{ solr_service_name }}"
solr_home: "/var/{{ solr_service_name }}"
solr_connect_host: localhost
solr_port: "8983"

solr_xms: "256M"
solr_xmx: "512M"

solr_timezone: "UTC"

solr_cores:
  - collection1

solr_config_file: /etc/default/{{ solr_service_name }}.in.sh

# Enable restart solr handler
solr_restart_handler_enabled: true

# Used only for Solr < 5.
solr_log_file_path: /var/log/solr.log
solr_host: "0.0.0.0"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-solr/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-solr/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|
|debian|all|
|ubuntu|docker, bionic|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| ubuntu:latest | bin/sh: 1: sudo: not found |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-solr/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
