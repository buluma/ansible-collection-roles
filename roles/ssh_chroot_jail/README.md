# [Ansible role ssh_chroot_jail](#ansible-role-ssh_chroot_jail)

Simple SSH chroot jail management.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-ssh_chroot_jail/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ssh_chroot_jail.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ssh_chroot_jail.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ssh_chroot_jail.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/ssh_chroot_jail)](https://galaxy.ansible.com/ui/standalone/roles/buluma/ssh_chroot_jail/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    ssh_chroot_l2chroot_path: /usr/bin/l2chroot
    ssh_chroot_jail_users:
      - name: foo
        home: /home/foo
        shell: /bin/bash

  roles:
    - role: buluma.ssh_chroot_jail
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/master/defaults/main.yml):

```yaml
---
ssh_chroot_jail_path: /var/jail

ssh_chroot_jail_group_name: ssh_jailed

ssh_chroot_jail_users: []
ssh_chroot_jail_dirs:
  - bin
  - dev
  - etc
  - lib
  - lib64
  - usr/bin
  - usr/lib
  - usr/lib64
  - home

# can include type: c, b, p
# c = char device (unbuffered) [the default]
# b = block device (buffered)
# p = FIFO device
# anything else may result in errors with mknod or systemd-tmpfiles
ssh_chroot_jail_devs:
  - { dev: "null", major: "1", minor: "3" }
  - { dev: "random", major: "5", minor: "0" }
  - { dev: "urandom", major: "1", minor: "5" }
  - { dev: "zero", major: "1", minor: "8" }

ssh_chroot_tmpfiles_conf_path: /etc/tmpfiles.d/ssh-chroot.conf

ssh_chroot_bins:
  - /bin/cp
  - /bin/sh
  - /bin/bash
  - /bin/ls
  - /bin/rm
  - /bin/cat
  - /bin/grep
  - /bin/sed
  - /bin/chmod
  - /bin/chown
  - /bin/ed
  - /bin/nano
  - /usr/bin/tail
  - /usr/bin/head
  - /usr/bin/awk
  - /usr/bin/wc
  - /usr/bin/sort
  - /usr/bin/uniq
  - /usr/bin/cut
  - /usr/bin/scp
  - /usr/bin/tee
  - /usr/bin/touch
  - /usr/bin/vim
  - /usr/bin/vi
  - /usr/bin/dircolors
  - /usr/bin/tput
  - /usr/bin/free
  - /usr/bin/top
  - /usr/bin/find
  - bin: /usr/bin/which
    l2chroot: false
  - /usr/bin/id
  - /usr/bin/whoami
  - /usr/bin/groups
  # Can also set mode, e.g. to setuid or set different permissions.
  # - bin: /bin/ping
  #   mode: 4755

ssh_chroot_l2chroot_template: l2chroot.j2
ssh_chroot_l2chroot_path: /usr/local/bin/l2chroot

ssh_chroot_copy_extra_items:
  - /etc/hosts
  - /etc/passwd
  - /etc/group
  - /etc/ld.so.cache
  - /etc/ld.so.conf
  - /etc/nsswitch.conf

ssh_chroot_sshd_chroot_jail_config: |
  Match group {{ ssh_chroot_jail_group_name }}
      ChrootDirectory {{ ssh_chroot_jail_path }}
      X11Forwarding no
      AllowTcpForwarding no

ssh_chroot_jail_dirs_recurse: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ssh_chroot_jail/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-ssh_chroot_jail/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
