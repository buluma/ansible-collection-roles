# [helm](#helm)

Helm for Kubernetes.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-helm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-helm/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-helm/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-helm)|[![quality](https://img.shields.io/ansible/quality/54861)](https://galaxy.ansible.com/buluma/helm)|[![downloads](https://img.shields.io/ansible/role/d/54861)](https://galaxy.ansible.com/buluma/helm)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-helm.svg)](https://github.com/buluma/ansible-role-helm/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-helm.svg)](https://github.com/buluma/ansible-role-helm/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-helm.svg)](https://github.com/buluma/ansible-role-helm/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.helm
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for helm
# for available releases: https://github.com/helm/helm/releases/
helm_version: 'v3.9.2'
helm_platform: linux
helm_arch: amd64

helm_repo_path: "https://get.helm.sh"

helm_bin_path: /usr/local/bin/helm
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-helm/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-helm/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-helm/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-helm/blob/master/CHANGELOG.md)

## [License](#license)

license (MIT)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
