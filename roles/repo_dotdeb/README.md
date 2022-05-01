# [repo_dotdeb](#repo_dotdeb)

DotDeb repository for Debian.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-repo_dotdeb/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-repo_dotdeb/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-repo_dotdeb/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-repo_dotdeb)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/repo_dotdeb)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/repo_dotdeb)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-repo_dotdeb.svg)](https://github.com/buluma/ansible-role-repo_dotdeb/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-repo_dotdeb.svg)](https://github.com/buluma/ansible-role-repo_dotdeb/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-repo_dotdeb.svg)](https://github.com/buluma/ansible-role-repo_dotdeb/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: buluma.repo_dotdeb
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
dotdeb_sources:
  - "deb http://packages.dotdeb.org {{ ansible_distribution_release }} all"
  - "deb-src http://packages.dotdeb.org {{ ansible_distribution_release }} all"
dotdeb_repo_gpg_key_url: https://www.dotdeb.org/dotdeb.gpg
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-repo_dotdeb/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-repo_dotdeb/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|

The minimum version of Ansible required is 2.0, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-repo_dotdeb/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-repo_dotdeb/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
