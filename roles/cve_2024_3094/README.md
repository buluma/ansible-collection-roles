# [Ansible role cve_2024_3094](#ansible-role-cve_2024_3094)

Check xz vulnerability (cve_2024_3094) on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-cve_2024_3094/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-cve_2024_3094/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-cve_2024_3094.svg)](https://github.com/buluma/ansible-role-cve_2024_3094/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-cve_2024_3094.svg)](https://github.com/buluma/ansible-role-cve_2024_3094/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-cve_2024_3094.svg)](https://github.com/buluma/ansible-role-cve_2024_3094/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/cve_2024_3094)](https://galaxy.ansible.com/ui/standalone/roles/buluma/cve_2024_3094/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-cve_2024_3094/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.cve_2024_3094
      cve_2024_3094_cleanup: false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-cve_2024_3094/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.openssh
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-cve_2024_3094/blob/master/defaults/main.yml):

```yaml
---
# defaults file for cve_2024_3094

# If requirements are installed, would you like to remove them after this role ran?
cve_2024_3094_cleanup: true

# Where to look for `sshd`, a list of paths.
cve_2024_3094_sshd_paths:
  - /usr/bin
  - /usr/sbin
  - /usr/local/bin
  - /usr/local/sbin
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-cve_2024_3094/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.openssh](https://galaxy.ansible.com/buluma/openssh)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssh/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssh/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-cve_2024_3094/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-cve_2024_3094/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-cve_2024_3094/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
