# [docker_arm](#docker_arm)

Docker setup for Rasbperry Pi and ARM-based devices.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-docker_arm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker_arm/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-docker_arm/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-docker_arm)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/docker_arm)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/docker_arm)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-docker_arm.svg)](https://github.com/buluma/ansible-role-docker_arm/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-docker_arm.svg)](https://github.com/buluma/ansible-role-docker_arm/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-docker_arm.svg)](https://github.com/buluma/ansible-role-docker_arm/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.docker_arm"
      include_role:
        name: "buluma.docker_arm"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for docker_arm

# Different ARM platforms may have different versions of Docker available. By
# default, this role will install the latest version available. You can override
# this behavior by setting a specific version, like:
#
# docker_version: 5:20.10.10~3-0~debian-buster (for arm64)
#
# Check available versions: `apt-cache madison docker-ce`
docker_version: "latest"

# Whether to install recommended packages alongside docker-ce.
docker_install_recommends: false

# Whether to install Docker Compose via Pip.
docker_install_compose: true

# A list of users who will be added to the docker group.
docker_users: []

# The executable to use for Pip.
docker_pip_executable: pip3
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-docker_arm/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-docker_arm/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-docker_arm/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-docker_arm/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
