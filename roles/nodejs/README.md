# [nodejs](#nodejs)

Node.js installation for Linux

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-nodejs/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nodejs/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nodejs/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nodejs)|[![quality](https://img.shields.io/ansible/quality/54975)](https://galaxy.ansible.com/buluma/nodejs)|[![downloads](https://img.shields.io/ansible/role/d/54975)](https://galaxy.ansible.com/buluma/nodejs)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nodejs.svg)](https://github.com/buluma/ansible-role-nodejs/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nodejs.svg)](https://github.com/buluma/ansible-role-nodejs/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nodejs.svg)](https://github.com/buluma/ansible-role-nodejs/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    nodejs_install_npm_user: root
    npm_config_prefix: /root/.npm-global
    npm_config_unsafe_perm: "true"
    nodejs_npm_global_packages:
      - node-sass
      - name: jslint
        version: 0.12.0
      - name: yo

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - role: buluma.nodejs
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Set the version of Node.js to install ("12.x", "13.x", "14.x", "15.x", etc.).
# Version numbers from Nodesource: https://github.com/nodesource/distributions
nodejs_version: "14.x"

# The user for whom the npm packages will be installed.
# nodejs_install_npm_user: username

# The directory for global installations.
npm_config_prefix: "/usr/local/lib/npm"

# Set to true to suppress the UID/GID switching when running package scripts. If
# set explicitly to false, then installing as a non-root user will fail.
npm_config_unsafe_perm: "false"

# Define a list of global packages to be installed with NPM.
nodejs_npm_global_packages: []
#  # Install a specific version of a package.
#  - name: jslint
#    version: 0.9.3
#  # Install the latest stable release of a package.
#  - name: node-sass
#  # This shorthand syntax also works (same as previous example).
#  - node-sass

# The path of a package.json file used to install packages globally.
nodejs_package_json_path: ""

# Whether or not /etc/profile.d/npm.sh (globa) must be generated.
# Set to false if you need to handle this manually with a per-user install.
nodejs_generate_etc_profile: "true"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nodejs/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nodejs/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nodejs/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-nodejs/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
