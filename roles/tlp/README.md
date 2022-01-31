# [tlp](#tlp)

Save laptop battery power using TLP

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-tlp/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-tlp/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-tlp/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-tlp)|[![quality](https://img.shields.io/ansible/quality/49809)](https://galaxy.ansible.com/buluma/tlp)|[![downloads](https://img.shields.io/ansible/role/d/49809)](https://galaxy.ansible.com/buluma/tlp)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-tlp.svg)](https://github.com/buluma/ansible-role-tlp/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.tlp
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
    - role: buluma.epel
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for tlp

# You can configure start and stop thresholds per battery.
# In CI there are not batteries, so disabling this list by default.

# tlp_batteries:
#   - name: BAT0
#     start_threshold: 70
#     stop_threshold: 90
#   - name: BAT1
#     start_threshold: 70
#     stop_threshold: 90
tlp_batteries: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-tlp/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-tlp/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|bullseye|
|el|8|
|fedora|all|
|opensuse|all|
|ubuntu|bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| ubuntu:latest | Can't locate Tie/Hash/NamedCapture.pm in @INC |
| debian:bullseye | Can't locate Tie/Hash/NamedCapture.pm in @INC |
| alpine | Starting TLP is not idempotent. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-tlp/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).