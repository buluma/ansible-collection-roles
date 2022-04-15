# [homebrew](#homebrew)

Homebrew for macOS

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-homebrew/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-homebrew/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-homebrew/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-homebrew)|[![quality](https://img.shields.io/ansible/quality/54862)](https://galaxy.ansible.com/buluma/homebrew)|[![downloads](https://img.shields.io/ansible/role/d/54862)](https://galaxy.ansible.com/buluma/homebrew)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-homebrew.svg)](https://github.com/buluma/ansible-role-homebrew/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-homebrew.svg)](https://github.com/buluma/ansible-role-homebrew/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-homebrew.svg)](https://github.com/buluma/ansible-role-homebrew/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.homebrew
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: elliotweiser.osx-command-line-tools
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
homebrew_repo: https://github.com/Homebrew/brew

homebrew_prefix: "{{ (ansible_machine == 'arm64') | ternary('/opt/homebrew', '/usr/local') }}"
homebrew_install_path: "{{ homebrew_prefix }}/Homebrew"
homebrew_brew_bin_path: "{{ homebrew_prefix }}/bin"

homebrew_installed_packages: []

homebrew_uninstalled_packages: []

homebrew_upgrade_all_packages: false

homebrew_taps:
  - homebrew/core

homebrew_cask_apps: []

homebrew_cask_uninstalled_apps: []

homebrew_cask_appdir: /Applications
homebrew_cask_accept_external_apps: false

homebrew_use_brewfile: true
homebrew_brewfile_dir: '~'

homebrew_clear_cache: false

homebrew_folders_additional: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-homebrew/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[elliotweiser.osx-command-line-tools](https://galaxy.ansible.com/buluma/elliotweiser.osx-command-line-tools)|[![Build Status GitHub](https://github.com/buluma/elliotweiser.osx-command-line-tools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/elliotweiser.osx-command-line-tools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/elliotweiser.osx-command-line-tools/badges/master/pipeline.svg)](https://gitlab.com/buluma/elliotweiser.osx-command-line-tools)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- elliotweiser.osx-command-line-tools
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-homebrew/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|macosx|all, any|

The minimum version of Ansible required is 2.5, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-homebrew/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
