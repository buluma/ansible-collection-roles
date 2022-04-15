# [update_pip_packages](#update_pip_packages)

Find and update pip packages.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-update_pip_packages/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-update_pip_packages/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-update_pip_packages/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-update_pip_packages)|[![quality](https://img.shields.io/ansible/quality/57928)](https://galaxy.ansible.com/buluma/update_pip_packages)|[![downloads](https://img.shields.io/ansible/role/d/57928)](https://galaxy.ansible.com/buluma/update_pip_packages)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-update_pip_packages.svg)](https://github.com/buluma/ansible-role-update_pip_packages/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.update_pip_packages
      update_pip_package_ignore:
        - libcomps
        - PyGObject
        - pygobject
        - pyxdg
        - resolvelib
        - dbus-python
        - setuptools
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
    - role: buluma.buildtools
    - role: buluma.python_pip
      python_pip_modules:
        - name: ansible
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for update_pip_packages

# A list of pip executables that will be use to get the packages.
# Either full path, or just name name of the executable.
# This role "discovers" pip and pip3 installations, but if you have a specific
# pip executalbe, you can add items to this list.
update_pip_packages_clients: []

# You can indicate to ignore a list of packages. Packages listed here will not be updated.
# update_pip_package_ignore:
#   - some_pip_package
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-update_pip_packages/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-update_pip_packages/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|el|8|
|fedora|34|
|opensuse|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-update_pip_packages/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
