# [adminer](#adminer)

Installs Adminer for Database management.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-adminer/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-adminer/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-adminer/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-adminer)|[![quality](https://img.shields.io/ansible/quality/59945)](https://galaxy.ansible.com/buluma/adminer)|[![downloads](https://img.shields.io/ansible/role/d/59945)](https://galaxy.ansible.com/buluma/adminer)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-adminer.svg)](https://github.com/buluma/ansible-role-adminer/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-adminer.svg)](https://github.com/buluma/ansible-role-adminer/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-adminer.svg)](https://github.com/buluma/ansible-role-adminer/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    adminer_add_apache_config: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.python_pip
    - role: buluma.apache
    - role: buluma.ca_certificates
    - role: buluma.openssl
    - role: buluma.adminer
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for adminer
adminer_download_url: https://www.adminer.org/latest.php
adminer_install_dir: /opt/adminer
adminer_install_filename: adminer.php
adminer_symlink_dirs: []
adminer_add_apache_config: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-adminer/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.apache](https://galaxy.ansible.com/buluma/apache)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apache/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apache)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-adminer/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|fedora|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-adminer/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-adminer/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
