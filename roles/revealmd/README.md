# [revealmd](#revealmd)

Install and configure revealmd on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-revealmd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-revealmd/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-revealmd/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-revealmd)|[![quality](https://img.shields.io/ansible/quality/21646)](https://galaxy.ansible.com/buluma/revealmd)|[![downloads](https://img.shields.io/ansible/role/d/21646)](https://galaxy.ansible.com/buluma/revealmd)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-revealmd.svg)](https://github.com/buluma/ansible-role-revealmd/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.revealmd
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
    - role: buluma.git
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for revealmd

# The directory where reveal-md should find presentations.
revealmd_directory: /data

# The exact presentation to process
revealmd_presentation: index.md

# The tcp port where reveal-md should listen on.
revealmd_port: 1948

# The theme to use.
# https://github.com/highlightjs/highlight.js/tree/master/src/styles
revealmd_options: --theme black
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-revealmd/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-git/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git)|
|[buluma.npm](https://galaxy.ansible.com/buluma/npm)|[![Build Status GitHub](https://github.com/buluma/ansible-role-npm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-npm/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-npm/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-npm)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.npm
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-revealmd/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|bullseye|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| centos:7 | /usr/lib/node_modules/reveal-md/bin/reveal-md.js:29 (async () => { |
| redhat:7 | /usr/lib/node_modules/reveal-md/bin/reveal-md.js:29 (async () => { |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-revealmd/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
