# [Ansible role gitlab_runner](#ansible-role-gitlab_runner)

Install and configure gitlab-runner on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-gitlab_runner/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-gitlab_runner/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-gitlab_runner.svg)](https://github.com/buluma/ansible-role-gitlab_runner/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-gitlab_runner.svg)](https://github.com/buluma/ansible-role-gitlab_runner/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-gitlab_runner.svg)](https://github.com/buluma/ansible-role-gitlab_runner/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/gitlab_runner)](https://galaxy.ansible.com/ui/standalone/roles/buluma/gitlab_runner/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-gitlab_runner/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.gitlab_runner
      gitlab_runner_tags:
        - docker
        - my_runner
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-gitlab_runner/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-gitlab_runner/blob/master/defaults/main.yml):

```yaml
---
# defaults file for gitlab_runner

# These are the setting you need to register a runner.
# gitlab_runner_registration_token: "123ABC"

# The name as shown in the GitLab webinterface.
gitlab_runner_name: "{{ ansible_facts['fqdn'] }}"

# The URL to register the runner to.
gitlab_runner_url: "https://gitlab.com/"

# The list of tags.
gitlab_runner_tags: []
# The type of executor. Choose from: "ssh", "shell", "parallels", "virtualbox",
# "docker", "docker_machine", "kubernetes" or "custom"
gitlab_runner_executor: docker

# The docker image to run.
gitlab_runner_docker_image: "alpine:latest"

# The version of the GitLab runner to install.
gitlab_runner_version: ""

# Set the amount of concurrent jobs.
gitlab_runner_concurrency: "{{ ansible_facts['processor_vcpus'] }}"

# Activate or deactivate privileged runner
gitlab_runner_privileged: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-gitlab_runner/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-gitlab_runner/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-gitlab_runner/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-gitlab_runner/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
