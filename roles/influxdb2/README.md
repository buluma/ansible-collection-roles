# [influxdb2](#influxdb2)

Install and configure InfluxDB 2.0 using Ansible.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-influxdb2/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-influxdb2/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-influxdb2/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-influxdb2)|[![quality](https://img.shields.io/ansible/quality/58620)](https://galaxy.ansible.com/buluma/influxdb2)|[![downloads](https://img.shields.io/ansible/role/d/58620)](https://galaxy.ansible.com/buluma/influxdb2)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-influxdb2.svg)](https://github.com/buluma/ansible-role-influxdb2/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-influxdb2.svg)](https://github.com/buluma/ansible-role-influxdb2/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-influxdb2.svg)](https://github.com/buluma/ansible-role-influxdb2/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  gather_facts: true
  become: yes
  vars:
    apt_autostart_state: enabled
    pip_package: python3-pip
    pip_executable: "{{ 'pip3' if pip_package.startswith('python3') else 'pip' }}"
    pip_install_packages:
      # Test installing a specific version of a package.
      - name: ipaddress
        version: "1.0.18"
      # Install setuptools
      - name: setuptools
      # Test installing a package by name.
      - name: requests

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    - name: Set package name for older OSes.
      set_fact:
        pip_package: python-pip
      when: >
        (ansible_os_family == 'RedHat') and (ansible_distribution_major_version | int < 8)
        or (ansible_distribution == 'Debian') and (ansible_distribution_major_version | int < 10)
        or (ansible_distribution == 'Ubuntu') and (ansible_distribution_major_version | int < 18)
  roles:
    - role: buluma.bootstrap
    - role: buluma.pip
    - role: buluma.influxdb2

      influxdb_orgs:
        - name: main-org
          description: Main organization
        - name: guest-org

      influxdb_users:
        - name: admin01
          org: main-org
          password: secretPassword
        - name: guest01
          org: guest-org
          password: secretPassword

      influxdb_buckets:
        - name: bucket01
          description: First bucket
          org: main-org
          retention: 1d
        - name: bucket02
          org: main-org
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare container
  hosts: all
  gather_facts: true
  become: yes
  serial: 30%
  vars:
    apt_autostart_state: enabled

  roles:
    - role: buluma.bootstrap
    - role: buluma.apt_autostart
    - role: buluma.pip

  post_tasks:
    - name: place /environmentfile.txt
      ansible.builtin.copy:
        content: "value=influxdb"
        dest: /environmentfile.txt
        mode: "0644"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
influxdb_dependencies:
  - apt-transport-https
  - curl
  - gnupg

influxdb_packages:
  - influxdb2
  - influxdb2-cli

influxdb_package_state: present

influxdb_config_path: /etc/influxdb
influxdb_bolt_path: /var/lib/influxdb/influxd.bolt
influxdb_engine_path: /var/lib/influxdb/engine

influxdb_host: http://localhost:8086

influxdb_config: {}
#  http-bind-address: 0.0.0.0:8086
#  reporting-disabled: true

influxdb_primary_org: example-org
influxdb_primary_bucket: example-bucket
influxdb_primary_username: example-user
influxdb_primary_password: ExAmPl3PA55W0rD

# Set your root token for admin user
influxdb_admin_token: EXAMPLE-TOKEN

influxdb_orgs: []
#  - name: main-org
#    description: Main organization
#  - name: guest-org

influxdb_users: []
#  - name: admin01
#    org: main-org
#    password: secretPassword
#  - name: guest01
#    org: guest-org
#    password: secretPassword

influxdb_buckets: []
#  - name: bucket01
#    description: First bucket
#    org: main-org
#    retention: 1d
#  - name: bucket02
#    description: Second bucket
#    org: main-org

influxdb_service_enabled: true

influxdb_service_state: started
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-influxdb2/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.influxdb2](https://galaxy.ansible.com/buluma/influxdb2)|[![Build Status GitHub](https://github.com/buluma/ansible-role-influxdb2/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-influxdb2/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-influxdb2/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-influxdb2)|
|[buluma.apt_autostart](https://galaxy.ansible.com/buluma/apt_autostart)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apt_autostart/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apt_autostart/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apt_autostart/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apt_autostart)|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.pip](https://galaxy.ansible.com/buluma/pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-pip)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-influxdb2/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|

The minimum version of Ansible required is 2.7, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-influxdb2/issues)

## [License](#license)

MIT

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
