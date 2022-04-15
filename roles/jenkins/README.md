# [jenkins](#jenkins)

Install and configure jenkins on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-jenkins/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-jenkins/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-jenkins/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-jenkins)|[![quality](https://img.shields.io/ansible/quality/57941)](https://galaxy.ansible.com/buluma/jenkins)|[![downloads](https://img.shields.io/ansible/role/d/57941)](https://galaxy.ansible.com/buluma/jenkins)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-jenkins.svg)](https://github.com/buluma/ansible-role-jenkins/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.jenkins
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
    - role: buluma.java
    - role: buluma.locale
    - role: buluma.core_dependencies
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for jenkins

# What tcp port Jenkins should listen to.
jenkins_port: 8080

# What address Jenkins should bind to.
jenkins_listen_address: "0.0.0.0"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-jenkins/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|
|[buluma.locale](https://galaxy.ansible.com/buluma/locale)|[![Build Status GitHub](https://github.com/buluma/ansible-role-locale/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-locale/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-locale/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-locale)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-jenkins/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|bullseye|
|el|all|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | tried to configure name using a file "/etc/sysconfig/clock", but could not write to it |
| amazonlinux | /etc/rc.d/init.d/jenkins: line 59: /etc/init.d/functions: No such file or directory |
| ubuntu:bionic | No openjdk 8, with openjdk 11 jenkins returns an error. |
| ubuntu:focal | No openjdk 8, with openjdk 11 jenkins returns an error. |
| opensuse | An initscript is not idempotent. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-jenkins/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
