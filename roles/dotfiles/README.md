# [dotfiles](#dotfiles)

Dotfile installation for UNIX/Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-dotfiles/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-dotfiles/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-dotfiles/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-dotfiles)|[![quality](https://img.shields.io/ansible/quality/58947)](https://galaxy.ansible.com/buluma/dotfiles)|[![downloads](https://img.shields.io/ansible/role/d/58947)](https://galaxy.ansible.com/buluma/dotfiles)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-dotfiles.svg)](https://github.com/buluma/ansible-role-dotfiles/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-dotfiles.svg)](https://github.com/buluma/ansible-role-dotfiles/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-dotfiles.svg)](https://github.com/buluma/ansible-role-dotfiles/pulls/)|

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

  roles:
    - role: buluma.dotfiles
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.git
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
dotfiles_repo: "https://github.com/buluma/dotfiles.git"
dotfiles_repo_version: master
dotfiles_repo_accept_hostkey: false
dotfiles_repo_local_destination: "~/Documents/dotfiles"

dotfiles_home: "~"
dotfiles_files:
  - .zshrc
  - .gitignore
  - .inputrc
  - .vimrc
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-dotfiles/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-git/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-dotfiles/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|fedora|all|
|debian|all|
|amazon|all|
|alpine|all|

The minimum version of Ansible required is 2.2, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-dotfiles/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-dotfiles/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
