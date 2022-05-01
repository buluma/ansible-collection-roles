# [image_builder](#image_builder)

Allow your system to use Lorax, the image builder.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-image_builder/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-image_builder/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-image_builder/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-image_builder)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/image_builder)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/image_builder)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-image_builder.svg)](https://github.com/buluma/ansible-role-image_builder/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-image_builder.svg)](https://github.com/buluma/ansible-role-image_builder/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-image_builder.svg)](https://github.com/buluma/ansible-role-image_builder/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.image_builder
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for image_builder

image_builder_product: blueprint-name
image_builder_description: My first blueprint
image_builder_version: 0.0.1

image_builder_installed_packages:
  - name: screen
    version: "4.*"
  - name: lsof
    version: "*"

# Use one of these values: alibaba, ami, ext4-filesystem, google, live-iso,
# openstack, partitioned-disk, qcow2, tar, vhd or vmdk
image_builder_type: tar
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-image_builder/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-image_builder/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|
|fedora|all|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-image_builder/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-image_builder/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
