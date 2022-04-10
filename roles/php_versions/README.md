# [php_versions](#php_versions)

Allows different PHP versions to be installed.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-php_versions/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php_versions/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-php_versions/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php_versions)|[![quality](https://img.shields.io/ansible/quality/58485)](https://galaxy.ansible.com/buluma/php_versions)|[![downloads](https://img.shields.io/ansible/role/d/58485)](https://galaxy.ansible.com/buluma/php_versions)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-php_versions.svg)](https://github.com/buluma/ansible-role-php_versions/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-php_versions.svg)](https://github.com/buluma/ansible-role-php_versions/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr/buluma/ansible-role-php_versions.svg)](https://github.com/buluma/ansible-role-php_versions/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    php_enable_webserver: false

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - role: geerlingguy.repo-remi
      when: ansible_os_family == 'RedHat'
    - role: buluma.php_versions
    - role: buluma.php

  post_tasks:
    - name: Confirm PHP version is correct.
      shell: php -v | grep -F '{{ php_version }}'
      changed_when: false
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# The PHP version to be installed.
php_version: '7.4'

# For Debian OSes only.
php_versions_install_recommends: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-php_versions/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[geerlingguy.repo-remi](https://galaxy.ansible.com/buluma/geerlingguy.repo-remi)|[![Build Status GitHub](https://github.com/buluma/geerlingguy.repo-remi/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/geerlingguy.repo-remi/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/geerlingguy.repo-remi/badges/master/pipeline.svg)](https://gitlab.com/buluma/geerlingguy.repo-remi)|
|[buluma.php_versions](https://galaxy.ansible.com/buluma/php_versions)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php_versions/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php_versions/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php_versions/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php_versions)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-php/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-php)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-php_versions/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-php_versions/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
