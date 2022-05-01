# [git_tag](#git_tag)

Ansible role to tag github repos.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-git_tag/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git_tag/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-git_tag/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git_tag)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/git_tag)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/git_tag)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-git_tag.svg)](https://github.com/buluma/ansible-role-git_tag/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-git_tag.svg)](https://github.com/buluma/ansible-role-git_tag/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-git_tag.svg)](https://github.com/buluma/ansible-role-git_tag/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.git_tag"
      include_role:
        name: "buluma.git_tag"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for git_tag
git_repo_location: .
git_remote: origin
update_git_tag: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-git_tag/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-git_tag/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|ubuntu|all|
|el|all|
|macosx|all|
|fedora|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-git_tag/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-git_tag/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
