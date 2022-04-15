# [kernel](#kernel)

Build and install a kernel

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-kernel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-kernel/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-kernel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-kernel)|[![quality](https://img.shields.io/ansible/quality/57952)](https://galaxy.ansible.com/buluma/kernel)|[![downloads](https://img.shields.io/ansible/role/d/57952)](https://galaxy.ansible.com/buluma/kernel)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-kernel.svg)](https://github.com/buluma/ansible-role-kernel/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.kernel
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
    - role: buluma.core_dependencies
    - role: buluma.buildtools
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for kernel

kernel_version: "5.15.5"

kernel_build_location: /tmp

kernel_parameters:
  - name: CONFIG_SMP
    value: y
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-kernel/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-kernel/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
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
| amazonlinux:1 | Not idempotent on: make modules_install |
| debian:bullseye | ./include/linux/filter.h:550:20: note: at offset 0 to object insnsi with size 0 declared here |
| alpine:edge | make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error |

## [Included version(s)](#included-versions)

This role [refers to a version](https://github.com/robertdebock/ansible-role-kernel/blob/master/defaults/main.yml) released by The Linux Kernel Archives. Check the released version(s) here:
- [the Linux kernel](https://www.kernel.org/).

This version reference means a role may get outdated. Monthly tests occur to see if [bit-rot](https://en.wikipedia.org/wiki/Software_rot) occured. If you however find a problem, please create an issue, I'll get on it as soon as possible.

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-kernel/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
