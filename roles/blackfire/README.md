# [blackfire](#blackfire)

Blackfire installation for Linux.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-blackfire/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-blackfire/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-blackfire/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-blackfire)|[![quality](https://img.shields.io/ansible/quality/24160)](https://galaxy.ansible.com/buluma/blackfire)|[![downloads](https://img.shields.io/ansible/role/d/24160)](https://galaxy.ansible.com/buluma/blackfire)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-blackfire.svg)](https://github.com/buluma/ansible-role-blackfire/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    php_enable_webserver: false
    php_enable_php_fpm: true

  handlers:
    - name: update apt cache
      apt: update_cache=true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    # Ubuntu-specific tasks.
    - name: Add dependencies for apt key (Ubuntu).
      apt:
        name: dirmngr
        state: present
      when: ansible_distribution == 'Ubuntu'

    - name: Add repository for PHP 7 (Ubuntu).
      apt_repository: repo='ppa:ondrej/php'
      when: ansible_distribution == 'Ubuntu'

    # Debian-specific tasks.
    - name: Add dependencies for PHP versions (Debian).
      apt:
        name:
          - apt-transport-https
          - ca-certificates
        state: present
      when: ansible_distribution == "Debian"

    - name: Add Ondrej Sury's apt key (Debian).
      apt_key:
        url: https://packages.sury.org/php/apt.gpg
        state: present
      when: ansible_distribution == "Debian"

    - name: Add Ondrej Sury's repo (Debian).
      apt_repository:
        repo: "deb https://packages.sury.org/php/ {{ ansible_distribution_release }} main"
        state: present
      when: ansible_distribution == "Debian"
      notify: update apt cache
    
    - name: Flush Handlers
      meta: flush_handlers

  roles:
    - role: buluma.php
    - role: buluma.blackfire
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
blackfire_packages:
  - blackfire-agent
  - blackfire-php

blackfire_gpg_key_url: https://packages.blackfire.io/gpg.key
blackfire_repo_url: http://packages.blackfire.io/fedora/blackfire.repo
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-blackfire/blob/main/requirements.txt).


## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.php
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-blackfire/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|
|debian|all|
|ubuntu|precise, raring, saucy, trusty, xenial, bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-blackfire/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
