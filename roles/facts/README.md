# [facts](#facts)

Place custom facts for Ansible on a system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-facts/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-facts/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-facts/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-facts)|[![quality](https://img.shields.io/ansible/quality/46400)](https://galaxy.ansible.com/buluma/facts)|[![downloads](https://img.shields.io/ansible/role/d/46400)](https://galaxy.ansible.com/buluma/facts)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-facts.svg)](https://github.com/buluma/ansible-role-facts/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.facts
      facts:
        - key: datacenter
          value: Amsterdam
        - key: availability_zone
          value: west
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

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for facts

# You can pass key value pair to this role, which will place the facts in
# `custom.fact`. For example this dictionary:

# facts:
#   - key: datacenter
#     value: Amsterdam
#   - key: availability_zone
#     value: west
#
# Would make these facts available:
#
#         "ansible_local": {
#             "custom": {
#                 "availability_zone": "west",
#                 "datacenter": "Amsterdam"
#             }
#         },

facts: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-facts/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-facts/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-facts/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
