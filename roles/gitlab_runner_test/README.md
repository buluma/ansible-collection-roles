# [gitlab_runner_test](#gitlab_runner_test)

Gitlab Runner Test

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-gitlab_runner_test/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-gitlab_runner_test/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-gitlab_runner_test/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-gitlab_runner_test)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/gitlab_runner_test)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/gitlab_runner_test)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-gitlab_runner_test.svg)](https://github.com/buluma/ansible-role-gitlab_runner_test/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-gitlab_runner_test.svg)](https://github.com/buluma/ansible-role-gitlab_runner_test/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-gitlab_runner_test.svg)](https://github.com/buluma/ansible-role-gitlab_runner_test/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  gather_facts: false
  become: true
  become_method: su
  tasks:
    - name: "Include buluma.gitlab_runner_test"
      ansible.builtin.include_role:
        name: "buluma.gitlab_runner_test"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for gitlab_runner_test
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-gitlab_runner_test/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.setuptools](https://galaxy.ansible.com/buluma/setuptools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-setuptools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-setuptools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-setuptools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-setuptools)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-gitlab_runner_test/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|all|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-gitlab_runner_test/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-gitlab_runner_test/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)

### [Special Thanks](#special-thanks)

Template inspired by [Robert de Bock](https://github.com/robertdebock)
