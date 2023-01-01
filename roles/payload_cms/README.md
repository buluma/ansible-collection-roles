# [payload_cms](#payload_cms)

Install and Configure Payload CMS.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-payload_cms/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-payload_cms/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-payload_cms/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-payload_cms)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/payload_cms)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/payload_cms)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-payload_cms.svg)](https://github.com/buluma/ansible-role-payload_cms/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-payload_cms.svg)](https://github.com/buluma/ansible-role-payload_cms/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-payload_cms.svg)](https://github.com/buluma/ansible-role-payload_cms/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  gather_facts: true

  roles:
    - role: buluma.payload_cms
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for payload_cms
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-payload_cms/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.npm](https://galaxy.ansible.com/buluma/npm)|[![Build Status GitHub](https://github.com/buluma/ansible-role-npm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-npm/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-npm/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-npm)|
|[buluma.nodejs](https://galaxy.ansible.com/buluma/nodejs)|[![Build Status GitHub](https://github.com/buluma/ansible-role-nodejs/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nodejs/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-nodejs/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nodejs)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-payload_cms/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-payload_cms/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-payload_cms/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
