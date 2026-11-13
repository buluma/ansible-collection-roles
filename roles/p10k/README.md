# [Ansible role p10k](#ansible-role-p10k)

Ansible role for installing powerlevel10k

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-p10k/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-p10k/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-p10k.svg)](https://github.com/buluma/ansible-role-p10k/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-p10k.svg)](https://github.com/buluma/ansible-role-p10k/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-p10k.svg)](https://github.com/buluma/ansible-role-p10k/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/p10k)](https://galaxy.ansible.com/ui/standalone/roles/buluma/p10k/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-p10k/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include ansible-role-p10k"
      ansible.builtin.include_role:
        name: "buluma.p10k"
      vars:
        zsh_plugin: "{{ lookup('env', 'zsh_plugin') | default('zsh', True) }}"
        p10k_prompt_style:
          "{{ lookup('env', 'p10k_prompt_style') | default('rainbow',
          True) }}"
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-p10k/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
      # - role: buluma.sudo
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-p10k/blob/master/defaults/main.yml):

```yaml
---
# defaults file for ansible-role-p10k

# Powerlevel10k Git repository url
p10k_repository_url: "https://github.com/romkatv/powerlevel10k.git"

# Install p10k for the following linux users
# Default: the linux user running Ansible
p10k_users:
  - "{{ ansible_facts['user_id'] }}"

# Zsh plugin used, zsh, ohmyzsh, prezto, Zim, etc..
# All plugin names can be found here https://github.com/romkatv/powerlevel10k#installation
zsh_plugin: zsh

# Setup p10k theme to use
# Valid values: lean, classic, rainbow, pure
p10k_prompt_style: "lean"

# Show current time
# Valid values: false, 24-hour, 12-hour
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
# or "p10k_prompt_frame" is not "false"
# Valid values: lightest, light, dark, darkest, black, white, green, blue
p10k_prompt_connection_color: "dark"

# Prompt frame connection
# Valid values: false, left, right, full
p10k_prompt_frame: left

# Sparse prompt with an empty line before promp
# Valid values: compact, sparse
p10k_prompt_spacing: compact

# Terminal flow
# Valid values: concise, fluent
p10k_prompt_flow: concise

# Enable transient prompt
# Valid values: true, false
p10k_transient_prompt: "false"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-p10k/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.sudo](https://galaxy.ansible.com/buluma/sudo)|[![Build Status GitHub](https://github.com/buluma/ansible-role-sudo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sudo/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-p10k/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-p10k/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-p10k/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
