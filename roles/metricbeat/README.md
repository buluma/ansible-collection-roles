# [Ansible role metricbeat](#ansible-role-metricbeat)

Install and configure Metricbeat, manage Metricbeat modules.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-metricbeat/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-metricbeat/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-metricbeat.svg)](https://github.com/buluma/ansible-role-metricbeat/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-metricbeat.svg)](https://github.com/buluma/ansible-role-metricbeat/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-metricbeat.svg)](https://github.com/buluma/ansible-role-metricbeat/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/metricbeat)](https://galaxy.ansible.com/ui/standalone/roles/buluma/metricbeat/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-metricbeat/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - metricbeat_elasticsearch_password: My-P@s5w0rd.
      metricbeat_modules:
        - name: system
          state: enabled
      role: buluma.metricbeat
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-metricbeat/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  vars:
    bootstrap_timeout: 300
    bootstrap_wait_for_host: true

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo for current user
      ansible.builtin.raw: |
        if id -u 1000 >/dev/null 2>&1; then
          USER=$(id -un 1000)
          echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-molecule
          chmod 440 /etc/sudoers.d/99-molecule
        elif [ -n "$SUDO_USER" ]; then
          echo "$SUDO_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-molecule
          chmod 440 /etc/sudoers.d/99-molecule
        else
          echo "root ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-molecule
          chmod 440 /etc/sudoers.d/99-molecule
        fi
      become: false
      changed_when: false
      failed_when: false

    - name: Install Debian/Ubuntu GPG keys if missing
      ansible.builtin.raw: |
        if [ -f /etc/debian_version ]; then
          apt-get update -y 2>/dev/null | grep -q 'NO_PUBKEY' && \
            apt-get install -y debian-archive-keyring ubuntu-archive-keyring 2>/dev/null || true
        fi
      become: false
      changed_when: false
      failed_when: false

    - name: Install Elastic GPG key on Debian/Ubuntu
      ansible.builtin.raw: |
        if [ -f /etc/debian_version ] && command -v apt-key >/dev/null 2>&1; then
          apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4 2>/dev/null || \
          curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - 2>/dev/null || true
        fi
      become: false
      changed_when: false
      failed_when: false

    - name: Wait for container to be ready
      ansible.builtin.wait_for_connection:
        timeout: 300
      become: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.core_dependencies
    - role: buluma.elastic_repo
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-metricbeat/blob/master/defaults/main.yml):

```yaml
---
metricbeat_elasticsearch_hosts:
  - http://localhost:9200
metricbeat_elasticsearch_password: ""
metricbeat_elasticsearch_username: elastic
metricbeat_kibana_host: "http://localhost:5601"
metricbeat_modules: []
metricbeat_version: "7.17.6"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-metricbeat/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|
|[buluma.elastic_repo](https://galaxy.ansible.com/buluma/elastic_repo)|[![Build Status GitHub](https://github.com/buluma/ansible-role-elastic_repo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-elastic_repo/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-metricbeat/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-metricbeat/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-metricbeat/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
