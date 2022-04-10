# [victoriametrics](#victoriametrics)

Ansible role for installing and configuring victoriametrics storage backend

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-victoriametrics/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-victoriametrics/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-victoria_metrics/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-victoria_metrics/-/commits/master)|[![quality](https://img.shields.io/ansible/quality/58577)](https://galaxy.ansible.com/buluma/victoriametrics)|[![downloads](https://img.shields.io/ansible/role/d/58577)](https://galaxy.ansible.com/buluma/victoriametrics)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-victoriametrics.svg)](https://github.com/buluma/ansible-role-victoriametrics/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-victoriametrics.svg)](https://github.com/buluma/ansible-role-victoriametrics/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-victoriametrics.svg)](https://github.com/buluma/ansible-role-victoriametrics/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.victoriametrics
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
proxy_env: {}
victoriametrics_version: 1.57.1
victoriametrics_web_listen_address: 0.0.0.0
victoriametrics_web_listen_port: 8428
victoriametrics_binary_install_dir: /usr/local/bin
victoriametrics_system_user: "{{ victoriametrics_user | default('prometheus') }}"
victoriametrics_system_group: "{{ victoriametrics_group | default('prometheus') }}"
victoriametrics_data_dir: /var/lib/victoriametrics
victoriametrics_config_dir: /etc/victoriametrics
victoriametrics_log_level: warn
victoriametrics_log_format: json
victoriametrics_prometheus_config: {}
victoriametrics_limit_nofile: 16384
victoriametrics_config:
  storageDataPath: "{{ victoriametrics_data_dir }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-victoriametrics/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-victoriametrics/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|fedora|all|
|el|all|
|ubuntu|focal, bionic|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-victoriametrics/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
