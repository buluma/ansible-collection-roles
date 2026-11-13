# [Ansible role docker_env](#ansible-role-docker_env)

Prepare Docker Environment for local testing.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-docker_env/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-docker_env/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-docker_env.svg)](https://github.com/buluma/ansible-role-docker_env/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-docker_env.svg)](https://github.com/buluma/ansible-role-docker_env/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-docker_env.svg)](https://github.com/buluma/ansible-role-docker_env/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/docker_env)](https://galaxy.ansible.com/ui/standalone/roles/buluma/docker_env/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-docker_env/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: localhost
  become: true
  gather_facts: true
  serial:
    - 1
    - 2
    - 25%
    - 50%
  vars:
    docker_requirements: docker
    prepare_ubuntu: true
    prepare_centos: true
    prepare_rockylinux: true
    prepare_fedora: true
    prune_ubuntu: false
    prune_centos: false
    prune_rockylinux: false
    prune_fedora: false
    container_default_behavior: "compatibility"

  roles:
    - role: buluma.docker_env
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-docker_env/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-docker_env/blob/master/defaults/main.yml):

```yaml
---
# defaults file for docker_env

# default container variables
docker_env_state: started
docker_env_command: sleep 1d
docker_env_privileged: true
docker_env_interactive: true
docker_env_tty: true
docker_env_capabilities:
  - SYS_ADMIN
docker_env_restart_policy: unless-stopped
container_default_behavior: no_defaults

# pull images/create containers
prepare_ubuntu: false
prepare_centos: false
prepare_rockylinux: false
prepare_fedora: false

# delete containers
prune_rockylinux: false
prune_centos: false
prune_ubuntu: false
prune_fedora: false

# prune everything, i.e. docker system prune
prune_everything: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-docker_env/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.docker](https://galaxy.ansible.com/buluma/docker)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-docker_env/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-docker_env/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-docker_env/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
