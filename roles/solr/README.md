# [Ansible role solr](#ansible-role-solr)

Apache Solr for Linux.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-solr/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-solr/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-solr.svg)](https://github.com/buluma/ansible-role-solr/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-solr.svg)](https://github.com/buluma/ansible-role-solr/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-solr.svg)](https://github.com/buluma/ansible-role-solr/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/solr)](https://galaxy.ansible.com/ui/standalone/roles/buluma/solr/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-solr/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  pre_tasks:
    - name: Set Java 8 package for RedHat.
      ansible.builtin.set_fact:
        java_packages:
          - java-1.8.0-openjdk
      when: ansible_facts['os_family'] == "RedHat"

    - name: Set Java 8 package for Ubuntu.
      ansible.builtin.set_fact:
        java_packages:
          - openjdk-8-jdk
      when: ansible_facts['os_family'] == "Ubuntu"

    - name: Set Java 11 package for Debian.
      ansible.builtin.set_fact:
        java_packages:
          - openjdk-11-jdk
      when: ansible_facts['os_family'] == "Debian"

    - name: Update apt cache.
      ansible.builtin.apt: update_cache=true cache_valid_time=600
      when: ansible_facts['os_family'] == "Debian"

      # See: http://unix.stackexchange.com/a/342469
    - name: Install dependencies (Debian).
      ansible.builtin.apt:
        name:
          - openjdk-11-jre-headless
          - ca-certificates-java
        state: present
      when: ansible_facts['distribution'] == "Debian"

  roles:
    - role: buluma.java
    - role: buluma.solr
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-solr/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.java
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-solr/blob/master/defaults/main.yml):

```yaml
---
solr_workspace: /root

solr_create_user: true
solr_user: solr
solr_group: "{{ solr_user }}"

solr_version: "8.11.2"
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

# solr_opts: "$SOLR_OPTS -Dlog4j2.formatMsgNoLookups=true"

solr_cores:
  - collection1

solr_default_core_path: "{% if solr_version.split('.')[0] < '9' %}{{ solr_install_path }}/example/files/conf/{% else %}{{ solr_install_path }}/server/solr/configsets/_default/conf/{%
  endif %}"

solr_config_file: /etc/default/{{ solr_service_name }}.in.sh

# Enable restart solr handler
solr_restart_handler_enabled: true

# Used only for Solr < 5.
solr_log_file_path: /var/log/solr.log
solr_host: "0.0.0.0"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-solr/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-solr/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-solr/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-solr/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
