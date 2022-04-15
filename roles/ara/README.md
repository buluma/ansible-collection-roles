# [ara](#ara)

Install and configure ara on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ara/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ara/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ara/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ara)|[![quality](https://img.shields.io/ansible/quality/58350)](https://galaxy.ansible.com/buluma/ara)|[![downloads](https://img.shields.io/ansible/role/d/58350)](https://galaxy.ansible.com/buluma/ara)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ara.svg)](https://github.com/buluma/ansible-role-ara/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ara.svg)](https://github.com/buluma/ansible-role-ara/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ara.svg)](https://github.com/buluma/ansible-role-ara/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.ara
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ara

# The ansible.cfg to modify.
ara_configuration_file: /etc/ansible/ansible.cfg

# The user to run ara as. Typically root, but if you run playbooks under your username, ara saves data in your homedirectory. In that case change the ara_user to your username.
ara_user: root

# This role tries to "find" python. If you are using a specific path to python,
# you can set `ara_callback_plugins`. For example:
# ara_python_plugins_path: /home/username/venv/site-packages/ara/plugins/callback

# Extra options can be set using this structure.
# ara_configuration:
#   - option: port
#     value: 9191
#   - option: host
#     value: "0.0.0.0"
#   - option: playbook_per_page
#     value: 10
#   - option: result_per_page
#     value: 25
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ara/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ara/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|ubuntu|bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | Could not find a version that satisfies the requirement Django>=2.1.5 |
| centos:7 | No matching distribution found for Django>=2.1.5 |
| amazonlinux:1 | No package matching 'python3-pip' |
| amazonlinux | No module named pkg_resources |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ara/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
