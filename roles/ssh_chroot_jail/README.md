# [ssh_chroot_jail](#ssh_chroot_jail)

Simple SSH chroot jail management.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ssh_chroot_jail/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ssh_chroot_jail/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ssh_chroot_jail)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/ssh_chroot_jail)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/ssh_chroot_jail)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ssh_chroot_jail.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ssh_chroot_jail.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ssh_chroot_jail.svg)](https://github.com/buluma/ansible-role-ssh_chroot_jail/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
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
  - {dev: 'null', major: '1', minor: '3'}
  - {dev: 'random', major: '5', minor: '0'}
  - {dev: 'urandom', major: '1', minor: '5'}
  - {dev: 'zero', major: '1', minor: '8'}

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

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ssh_chroot_jail/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|
|fedora|all|
|amazon|all|
|opensuse|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ssh_chroot_jail/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-ssh_chroot_jail/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
