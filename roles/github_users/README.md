# [github_users](#github_users)

Create users based on GitHub accounts.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-github_users/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-github_users/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-github_users/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-github_users)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/github_users)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/github_users)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-github_users.svg)](https://github.com/buluma/ansible-role-github_users/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-github_users.svg)](https://github.com/buluma/ansible-role-github_users/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-github_users.svg)](https://github.com/buluma/ansible-role-github_users/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    github_users_absent:
      - johndoe
      - janedoe

  roles:
    - role: buluma.github_users
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
github_users: []
# You can specify an object with 'name' (required) and 'groups' (optional):
# - name: buluma
#   groups: www-data,sudo

# Or you can specify a GitHub username directly:
# - buluma

github_users_absent: []
# You can specify an object with 'name' (required):
# - name: buluma

# Or you can specify a GitHub username directly:
# - buluma

github_users_authorized_keys_exclusive: true

github_url: https://github.com
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-github_users/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-github_users/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-github_users/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-github_users/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael buluma](https://buluma.github.io/)
