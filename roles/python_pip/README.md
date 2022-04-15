# [python_pip](#python_pip)

Install pythons pip on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|[![quality](https://img.shields.io/ansible/quality/57863)](https://galaxy.ansible.com/buluma/python_pip)|[![downloads](https://img.shields.io/ansible/role/d/57863)](https://galaxy.ansible.com/buluma/python_pip)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-python_pip.svg)](https://github.com/buluma/ansible-role-python_pip/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.python_pip
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
    - role: buluma.epel
    - role: buluma.buildtools
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for python_pip

# By default no modules should be installed.
python_pip_modules: []

# Connect to a (pypi) proxy by setting this variable.
# python_pip_proxy: "https://user:password@proxy:8443/artifactory/pypi/pypi-virtual/simple"

# Don't forget to trust foreign pip repositories if you use them.
# python_pip_trusted_host: my-pip-repository.example.com

# You can have this role update pip, using pip.
python_pip_update: yes

# You can use something other than the default pip binary.
# python_pip_executable: pip3
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-python_pip/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-python_pip/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| amazonlinux | python2 is installed already. |
| alpine | Failed to create temporary directory. |
| centos:7 | CentOS 7 uses python2, which is EOL. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-python_pip/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
