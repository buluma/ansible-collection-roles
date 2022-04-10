# [vector](#vector)

Vector Role

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-vector/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-vector/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-vector/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-vector)|[![quality](https://img.shields.io/ansible/quality/58678)](https://galaxy.ansible.com/buluma/vector)|[![downloads](https://img.shields.io/ansible/role/d/58678)](https://galaxy.ansible.com/buluma/vector)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-vector.svg)](https://github.com/buluma/ansible-role-vector/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-vector.svg)](https://github.com/buluma/ansible-role-vector/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-vector.svg)](https://github.com/buluma/ansible-role-vector/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  roles:
    - role: buluma.vector
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---

## General
# Version
vector_version: 0.10.0
vector_package_architecture: amd64

# Deb
vector_deb_package: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_package_architecture }}.deb"

# Set true to force the download and installation of the package
vector_force_reinstall: false

# Paths
vector_bin_path: "/usr/bin"
vector_skeleton_paths:
  - "{{ vector_bin_path }}"
vector_exec_name: vector

## Service options
# Documentation
vector_documentation_link: https://vector.dev/docs/about/what-is-vector/

# Owner
vector_user: vector
vector_group: vector
# Maybe you will need some extra groups for user vector
# vector_groups: []

# Start on boot
vector_service_enabled: True
# Current state: started, stopped
vector_service_state: started

# Logs
# If wanted to output the logs to a file define the following variable
# More information at https://www.freedesktop.org/software/systemd/man/systemd.exec.html#StandardOutput=
vector_log_output: journal

vector_config_template_path: "vector.toml.j2"
vector_service_template_path: "vector.service.j2"

vector_data_dir: "/var/lib/vector"
# vector_syslog_identifier: vector
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-vector/blob/main/requirements.txt).

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|

The minimum version of Ansible required is 2.9.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-vector/issues)

## [License](#license)

Apache 2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
