# [types](#types)

Try variables for their type.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-types/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-types/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-types/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-types)|[![quality](https://img.shields.io/ansible/quality/58809)](https://galaxy.ansible.com/buluma/types)|[![downloads](https://img.shields.io/ansible/role/d/58809)](https://galaxy.ansible.com/buluma/types)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-types.svg)](https://github.com/buluma/ansible-role-types/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-types.svg)](https://github.com/buluma/ansible-role-types/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-types.svg)](https://github.com/buluma/ansible-role-types/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.types
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
# defaults file for types

# A list of strings.
types_strings:
  - "hello"
  - "1.2.3"

# A list of integers.
types_integers:
  - 0
  - 1
  - 2

# A list of booleans.
types_booleans:
  - yes
  - Yes
  - YES
  - true
  - True
  - TRUE
  - no
  - No
  - NO
  - false
  - False
  - FALSE

# A list of floats.
types_floats:
  - 0.0
  - 0.1

# A map.
types_map:
  value1: something
  value2: not-something
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-types/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-types/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-types/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-types/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
