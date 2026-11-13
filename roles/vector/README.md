# [Ansible role vector](#ansible-role-vector)

Vector Role

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-vector/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-vector/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-vector.svg)](https://github.com/buluma/ansible-role-vector/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-vector.svg)](https://github.com/buluma/ansible-role-vector/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-vector.svg)](https://github.com/buluma/ansible-role-vector/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/vector)](https://galaxy.ansible.com/ui/standalone/roles/buluma/vector/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-vector/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  gather_facts: false
  roles:
    - role: buluma.vector
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-vector/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.ca_certificates
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-vector/blob/master/defaults/main.yml):

```yaml
---
vector_bin_path: /usr/bin/{{ vector_exec_name }}
vector_config_path: /etc/vector
vector_config_template_path: templates/config/
vector_configs_folder: "{{ vector_config_path }}"
vector_data_dir: /var/lib/vector
vector_deb_package: "https://apt.vector.dev/pool/v/vector/vector_{{ vector_version }}-1_{{ vector_package_architecture }}.deb"
vector_documentation_link: "https://vector.dev/docs/about/what-is-vector/"
vector_env_path: /etc/default/vector
vector_exec_name: vector
vector_force_reinstall: false
vector_group: vector
vector_log_output: journal
vector_package_architecture: amd64
vector_service_enabled: true
vector_service_state: started
vector_service_template_path: vector.service.j2
vector_skeleton_paths: "{{ vector_skeleton_paths_base + vector_skeleton_paths_extend | default([]) }}"
vector_skeleton_paths_base:
  - "{{ vector_config_path }}"
vector_user: vector
vector_version: "0.60.0"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-vector/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-vector/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-vector/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-vector/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
