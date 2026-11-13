# [Ansible role nvim](#ansible-role-nvim)

Install and Configure NVIM on your Linux systems.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-nvim/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-nvim/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nvim.svg)](https://github.com/buluma/ansible-role-nvim/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nvim.svg)](https://github.com/buluma/ansible-role-nvim/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nvim.svg)](https://github.com/buluma/ansible-role-nvim/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/nvim)](https://galaxy.ansible.com/ui/standalone/roles/buluma/nvim/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-nvim/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  vars:
    nvim_user: shadowwalker
    neovim: true
    neovim_nightly: false
    neovim_pip3_state: false
    treesitter: true
  tasks:
    - name: Adding user
      ansible.builtin.user:
        name: "{{ nvim_user }}"
        create_home: true
        shell: /bin/bash

    - name: Run nvim role
      ansible.builtin.include_role:
        name: buluma.nvim
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-nvim/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.ca_certificates
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-nvim/blob/master/defaults/main.yml):

```yaml
---
# application versions
neovim_version: "0.12.6"
treesitter_version: "0.27.1"

# variables for downloading appimages
nvim_dl_dir: "/opt/nvim/{{ neovim_version }}"
nvim_appimage_url: "https://github.com/neovim/neovim/releases/download/v{{ neovim_version }}/nvim-linux-x86_64.appimage"
treesitter_dl_dir: "/opt/treesitter/{{ treesitter_version }}"
treesitter_dl_name: "tree-sitter-linux-x64.gz"
treesitter_archive_url: "https://github.com/tree-sitter/tree-sitter/releases/download/v{{ treesitter_version }}/{{ treesitter_dl_name }}"
treesitter_filename: "tree-sitter-linux-x64"

# toggles for end-users
neovim: true
treesitter: true
neovim_nightly: false

neovim_pde: false
neovim_apt_packages: []
neovim_pip_packages: []
neovim_npm_packages: []
neovim_config_dirs: []
neovim_external_config: []
neovim_config_syncs: []
# digging deeper
neovim_pip3_packager_state: latest
neovim_npm_packager_state: latest
neovim_pip3_state: latest
neovim_apt_state: latest
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nvim/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nvim/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-nvim/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-nvim/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
