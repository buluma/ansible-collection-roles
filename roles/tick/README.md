# [tick](#tick)

Install, configure TICK.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-tick/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-tick/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-tick/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-tick)|[![quality](https://img.shields.io/ansible/quality/58303)](https://galaxy.ansible.com/buluma/tick)|[![downloads](https://img.shields.io/ansible/role/d/58303)](https://galaxy.ansible.com/buluma/tick)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-tick.svg)](https://github.com/buluma/ansible-role-tick/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: no
  vars:
    ansible_remote_tmp: /tmp/ansible

  roles:
    - role: buluma.tick
    - role: buluma.bootstrap
    - role: buluma.buildtools
    - role: buluma.docker_ce
    - role: buluma.docker
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
    - role: buluma.docker
    - role: buluma.docker_ce
    - role: buluma.buildtools
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-tick/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.docker](https://galaxy.ansible.com/buluma/docker)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-docker/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-docker)|
|[buluma.docker_ce](https://galaxy.ansible.com/buluma/docker_ce)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker_ce/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker_ce/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-docker_ce/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-docker_ce)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.docker
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-tick/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-tick/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
