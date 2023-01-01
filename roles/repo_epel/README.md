# [repo_epel](#repo_epel)

EPEL repository for RHEL/CentOS.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-repo_epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-repo_epel/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-repo_epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-repo_epel)|[![quality](https://img.shields.io/ansible/quality/58514)](https://galaxy.ansible.com/buluma/repo_epel)|[![downloads](https://img.shields.io/ansible/role/d/58514)](https://galaxy.ansible.com/buluma/repo_epel)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-repo_epel.svg)](https://github.com/buluma/ansible-role-repo_epel/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-repo_epel.svg)](https://github.com/buluma/ansible-role-repo_epel/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-repo_epel.svg)](https://github.com/buluma/ansible-role-repo_epel/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: buluma.repo_epel
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
epel_repo_url: "https://dl.fedoraproject.org/pub/epel/epel-release-latest-{{ ansible_distribution_major_version }}.noarch.rpm"
epel_repo_gpg_key_url: "https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-{{ ansible_distribution_major_version }}"
epel_repofile_path: "/etc/yum.repos.d/epel.repo"
epel_repo_disable: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-repo_epel/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-repo_epel/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|

The minimum version of Ansible required is 2.5, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-repo_epel/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
