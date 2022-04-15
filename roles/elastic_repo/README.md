# [elastic_repo](#elastic_repo)

Install the Elastic repository on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-elastic_repo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-elastic_repo/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-elastic_repo/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-elastic_repo)|[![quality](https://img.shields.io/ansible/quality/58805)](https://galaxy.ansible.com/buluma/elastic_repo)|[![downloads](https://img.shields.io/ansible/role/d/58805)](https://galaxy.ansible.com/buluma/elastic_repo)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-elastic_repo.svg)](https://github.com/buluma/ansible-role-elastic_repo/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-elastic_repo.svg)](https://github.com/buluma/ansible-role-elastic_repo/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-elastic_repo.svg)](https://github.com/buluma/ansible-role-elastic_repo/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.elastic_repo
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
    - role: buluma.core_dependencies
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for elastic_repo

# The software is free to use under the Elastic license.
# An alternative package which contains only features that are available
# under the Apache 2.0 license is also available.

# Elastic has two versions of the packages:
# - "elastic" using the "Elastic" license.
# - "oss" using the Apache 2.0 license.
elastic_repo_license: oss
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-elastic_repo/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-elastic_repo/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|all|
|debian|all|
|el|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-elastic_repo/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
