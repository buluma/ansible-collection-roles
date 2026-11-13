# [Ansible role mailhog](#ansible-role-mailhog)

MailHog for Linux

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-mailhog/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-mailhog/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mailhog.svg)](https://github.com/buluma/ansible-role-mailhog/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mailhog.svg)](https://github.com/buluma/ansible-role-mailhog/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mailhog.svg)](https://github.com/buluma/ansible-role-mailhog/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/mailhog)](https://galaxy.ansible.com/ui/standalone/roles/buluma/mailhog/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-mailhog/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: false
  gather_facts: true

  pre_tasks:
    - name: Update apt cache.
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 600
      when: ansible_facts['os_family'] == 'Debian'
    - name: Ensure build dependencies are installed (RedHat).
      ansible.builtin.package:
        name:
          - "@Development tools"
          - tar
          - unzip
          - net-tools
          - curl-minimal
        state: present
      when: ansible_facts['os_family'] == 'RedHat'
    - name: Ensure build dependencies are installed (Debian).
      ansible.builtin.apt:
        name:
          - build-essential
          - tar
          - unzip
          - net-tools
          - curl
        state: present
      when: ansible_facts['os_family'] == 'Debian'

  roles:
    - role: buluma.daemonize
    - role: buluma.mailhog

  post_tasks:
    - name: Copy test message into place.
      ansible.builtin.copy:
        dest: /tmp/test-message
        mode: "0644"
        src: test-message
    - name: Send an email via mhsendmail.
      ansible.builtin.shell:
        cmd: cat /tmp/test-message | /opt/mailhog/mhsendmail johndoe@example.com
      changed_when: false
    - name: Test retrieiving messages from the MailHog API.
      ansible.builtin.uri:
        url: http://localhost:8025/api/v2/messages
      delay: 1
      register: result
      retries: 60
      until: result.status == 200
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-mailhog/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-mailhog/blob/master/defaults/main.yml):

```yaml
---
mailhog_binary_url: "https://github.com/mailhog/MailHog/releases/download/v{{ mailhog_version }}/MailHog_linux_amd64"
mailhog_daemonize_bin_path: /usr/sbin/daemonize
mailhog_install_dir: /opt/mailhog
mailhog_version: "1.0.1"
mhsendmail_binary_url: "https://github.com/mailhog/mhsendmail/releases/download/v{{ mhsendmail_version }}/mhsendmail_linux_amd64"
mhsendmail_version: "0.2.0"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mailhog/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.daemonize](https://galaxy.ansible.com/buluma/daemonize)|[![Build Status GitHub](https://github.com/buluma/ansible-role-daemonize/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-daemonize/actions)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- {'role': 'buluma.daemonize'}

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mailhog/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-mailhog/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-mailhog/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
