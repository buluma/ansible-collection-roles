# [ubuntu_setup](#ubuntu_setup)

Setup and configure fresh Ubuntu installation.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ubuntu_setup/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ubuntu_setup/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ubuntu_setup/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ubuntu_setup)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/ubuntu_setup)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/ubuntu_setup)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ubuntu_setup.svg)](https://github.com/buluma/ansible-role-ubuntu_setup/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ubuntu_setup.svg)](https://github.com/buluma/ansible-role-ubuntu_setup/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ubuntu_setup.svg)](https://github.com/buluma/ansible-role-ubuntu_setup/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: utm-ubuntu
  tasks:
    - name: "Include buluma.ubuntu_setup"
      ansible.builtin.include_role:
        name: "buluma.ubuntu_setup"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ubuntu_setup

ansible_become_password: shadow
zsh_plugin: "{{ lookup('env', 'zsh_plugin') | default('zsh', True) }}"
p10k_prompt_height: one-line
p10k_prompt_spacing: compact
p10k_prompt_style: "{{ lookup('env', 'p10k_prompt_style') | default('lean', True) }}"
atom_apm_packages:
  - linter
  - platformio-ide-terminal
  - teletype

# apache default variables
apache_listen_port_ssl: 80
apache_create_vhosts: true
apache_vhosts_filename: "vhosts.conf"
apache_vhosts:
  - servername: "localhost"
    documentroot: "/var/www/vhosts/localhost"

# firefox default variables
firefox_desktop_icon: true
firefox_home: /opt/firefox-{{ firefox_version }}
firefox_image_path: "firefox/browser/chrome/icons/default/default128.png"
firefox_logo: "{{ firefox_home }}/{{ firefox_image_path }}"

#zsh default variables
zsh_antigen_bundles_extras:
  - nvm
  - joel-porquet/zsh-dircolors-solarized
zsh_autosuggestions_bind_key: "^U"

# pip default variables
pip_install_packages:
  # Test installing a specific version of a package.
  - name: ipaddress
    version: "1.0.18"
  # Test installing a package by name.
  - colorama
  - molecule
  - docker

# docker role variables
docker_privileged_users:
  - shadowwalker
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ubuntu_setup/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ubuntu_setup/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|focal, jammy|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ubuntu_setup/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-ubuntu_setup/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
