# [p10k](#p10k)

Ansible role for installing powerlevel10k

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-p10k/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-p10k/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-p10k/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-p10k)|[![quality](https://img.shields.io/ansible/quality/60075)](https://galaxy.ansible.com/buluma/p10k)|[![downloads](https://img.shields.io/ansible/role/d/60075)](https://galaxy.ansible.com/buluma/p10k)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-p10k.svg)](https://github.com/buluma/ansible-role-p10k/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-p10k.svg)](https://github.com/buluma/ansible-role-p10k/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-p10k.svg)](https://github.com/buluma/ansible-role-p10k/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.p10k"
      ansible.builtin.include_role:
        name: "buluma.p10k"
      vars:
        zsh_plugin: "{{ lookup('env', 'zsh_plugin') | default('zsh', True) }}"
        p10k_prompt_style: "{{ lookup('env', 'p10k_prompt_style') | default('rainbow', True) }}"
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  tasks:
    - name: Ubuntu/Debian | refresh apt repository
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_pkg_mgr == "apt"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ansible-role-p10k

# Powerlevel10k Git repository url
p10k_repository_url: 'https://github.com/romkatv/powerlevel10k.git'

# Install p10k for the following linux users
# Default: the linux user running Ansible
p10k_users:
  - "{{ ansible_user_id }}"

# Zsh plugin used, zsh, ohmyzsh, prezto, Zim, etc..
# All plugin names can be found here https://github.com/romkatv/powerlevel10k#installation
zsh_plugin: zsh

# Setup p10k theme to use
# Valid values: lean, classic, rainbow, pure
p10k_prompt_style: "lean"

# Show current time
# Valid values: no, 24-hour, 12-hour
p10k_prompt_time: "24-hour"

# Prompt separator
# Valid values: angled, vertical, slanted, round
p10k_prompt_separator: "angled"

# Prompt heads
# Valid values: sharp, blurred, slanted, round
p10k_prompt_head: "sharp"

# Prompt tails
# Valid values: flat, blurred, sharp, slanted, round
p10k_prompt_tails: flat

# Terminal prompt height
# Valid values: one-line, two-lines
p10k_prompt_height: one-line

# Prompt connection, only used if "p10k_prompt_height" value is "two-lines"
# Valid values: disconnected, dotted, solid
p10k_prompt_connection: disconnected

# Prompt connection color, only used if
# "p10k_prompt_connection" value is "dotted" or "solid"
# or "p10k_prompt_frame" is not "no"
# Valid values: lightest, light, dark, darkest, black, white, green, blue
p10k_prompt_connection_color: "dark"

# Prompt frame connection
# Valid values: no, left, right, full
p10k_prompt_frame: left

# Sparse prompt with an empty line before promp
# Valid values: compact, sparse
p10k_prompt_spacing: compact

# Terminal flow
# Valid values: concise, fluent
p10k_prompt_flow: concise

# Enable transient prompt
# Valid values: yes, no
p10k_transient_prompt: "no"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-p10k/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-p10k/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|fedora|all|
|debian|all|
|ubuntu|all|
|opensuse|all|

The minimum version of Ansible required is 2.8, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-p10k/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-p10k/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
