# [rclone](#rclone)

Install rclone on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-rclone/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-rclone/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-rclone/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-rclone)|[![quality](https://img.shields.io/ansible/quality/58878)](https://galaxy.ansible.com/buluma/rclone)|[![downloads](https://img.shields.io/ansible/role/d/58878)](https://galaxy.ansible.com/buluma/rclone)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-rclone.svg)](https://github.com/buluma/ansible-role-rclone/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-rclone.svg)](https://github.com/buluma/ansible-role-rclone/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-rclone.svg)](https://github.com/buluma/ansible-role-rclone/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:

    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    - name: Wait for systemd to complete initialization.     # noqa 303
      command: systemctl is-system-running
      register: systemctl_status
      until: >
        'running' in systemctl_status.stdout or
        'degraded' in systemctl_status.stdout
      retries: 30
      delay: 5
      when: ansible_distribution == 'Fedora'
      changed_when: false

    - name: Show ansible version
      ansible.builtin.debug:
        msg: "Ansible Version: {{ ansible_version.full }}"

  roles:
    - role: buluma.rclone
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
  # - role: buluma.openssl
  - role: buluma.core_dependencies
  - role: buluma.ca_certificates
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# rclone_arch can be defined as an architecture (e.g. arm, mips, 386) listed at https://github.com/ncw/rclone/releases
rclone_arch: amd64

# release of rclone to use. 'default' or 'beta' are accepted
rclone_release: stable

rclone_version: '{{ ansible_local.rclone.version | d("0.0.0") }}'

install_manpages: true

# Defaults in case no variables for OS are chosen
rclone_setup_tmp_dir: "/tmp/rclone_setup"

# The location to install the config file if configured
rclone_config_location: "/root/.config/rclone/rclone.conf"

rclone_packages:
  - unzip

rclone_man_pages:
  OWNER: root
  GROUP: root
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-rclone/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-rclone/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-rclone/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-rclone/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael buluma](https://buluma.github.io/)
