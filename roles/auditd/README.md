# [Ansible role auditd](#ansible-role-auditd)

Install and configure auditd on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-auditd/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-auditd/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-auditd.svg)](https://github.com/buluma/ansible-role-auditd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-auditd.svg)](https://github.com/buluma/ansible-role-auditd/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-auditd.svg)](https://github.com/buluma/ansible-role-auditd/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/auditd)](https://galaxy.ansible.com/ui/standalone/roles/buluma/auditd/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-auditd/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.auditd
      auditd_start_service: false
      auditd_local_events: "no"
      auditd_rules:
        - file: /var/log/audit/
          keyname: auditlog
        - file: /etc/audit/
          permissions:
            - write
            - attribute_change
          keyname: auditconfig
        - file: /etc/libaudit.conf
          permissions:
            - write
            - attribute_change
          keyname: auditconfig
        - file: /etc/audisp/
          permissions:
            - write
            - attribute_change
          keyname: audispconfig
        - file: /sbin/auditctl
          permissions:
            - execute
          keyname: audittools
        - file: /sbin/auditd
          permissions:
            - execute
          keyname: audittools
        - syscall: open
          action: always
          filter: exit
          filters:
            - auid!=4294967295
            - auid!=unset
          keyname: my_keyname
          arch: b32
        - syscall: adjtimex
          action: always
          filter: exit
          keyname: time_change
        - syscall: settimeofday
          action: always
          filter: exit
          keyname: time_change
        - action: always
          filter: exit
          filters:
            - path=/bin/ping
            - perm=x
            - auid>=500
            - auid!=4294967295
          keyname: privileged
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-auditd/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-auditd/blob/master/defaults/main.yml):

```yaml
---
# defaults file for auditd

# Below variables are docuemented in the man page for auditd.conf
# https://linux.die.net/man/5/auditd.conf
auditd_buffer_size: 32768
auditd_fail_mode: 1
auditd_maximum_rate: 60
auditd_enable_flag: 1
auditd_local_events: "yes"
auditd_write_logs: "yes"
auditd_log_file: /var/log/audit/audit.log
auditd_log_group: root
auditd_log_format: RAW
auditd_flush: incremental_async
auditd_freq: 50
auditd_max_log_file: 8
auditd_num_logs: 5
auditd_priority_boost: 4
auditd_disp_qos: lossy
auditd_dispatcher: /sbin/audispd
auditd_name_format: none
auditd_max_log_file_action: rotate
auditd_space_left: "75" # This can be a number ('25') or a percentage. ('25%')
auditd_space_left_action: syslog
auditd_verify_email: "yes"
auditd_action_mail_acct: root
auditd_admin_space_left: 50
auditd_admin_space_left_action: suspend
auditd_disk_full_action: suspend
auditd_disk_error_action: suspend
auditd_use_libwrap: "yes"
auditd_tcp_listen_queue: 5
auditd_tcp_max_per_addr: 1
auditd_tcp_client_max_idle: 0
auditd_enable_krb5: "no"
auditd_krb5_principal: auditd
auditd_distribute_network: "no"

# You can opt to manage the rules with this role or not.
# Setting auditd_manage_rules to false will not manage the rules.
auditd_manage_rules: true

# Some rules require a specific architecture to be set.
auditd_default_arch: b64

# You can opt to start the auditd service or not.
# Mostly useful in CI, to avoid starting the service.
auditd_start_service: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-auditd/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-auditd/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-auditd/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-auditd/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
