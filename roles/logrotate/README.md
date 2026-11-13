# [Ansible role logrotate](#ansible-role-logrotate)

Install and configure logrotate on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-logrotate/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-logrotate/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-logrotate.svg)](https://github.com/buluma/ansible-role-logrotate/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-logrotate.svg)](https://github.com/buluma/ansible-role-logrotate/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-logrotate.svg)](https://github.com/buluma/ansible-role-logrotate/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/logrotate)](https://galaxy.ansible.com/ui/standalone/roles/buluma/logrotate/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-logrotate/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  vars:
    logrotate_frequency: daily
    logrotate_keep: 7
    logrotate_compress: true
    logrotate_entries:
      - name: example
        path: "/var/log/example/*.log"
      - name: example-frequency
        path: "/var/log/example-frequency/*.log"
        frequency: weekly
      - name: example-keep
        path: "/var/log/example-keep/*.log"
        keep: 14
      - name: example-compress
        path: "/var/log/example-compress/*.log"
        compress: true
      - name: example-copylog
        path: "/var/log/example-copylog/*.log"
        copylog: true
      - name: example-copytruncate
        path: "/var/log/example-copytruncate/*.log"
        copytruncate: true
      - name: example-delaycompress
        path: "/var/log/example-delaycompress/*.log"
        delaycompress: true
      - name: example-script
        path: "/var/log/example-script/*.log"
        postrotate: killall -HUP some_process_name
      - name: btmp
        path: /var/log/btmp
        missingok: true
        frequency: monthly
        create: true
        create_mode: "0660"
        create_user: root
        create_group: utmp
        dateext: true
        dateformat: "-%Y-%m-%d"
        keep: 1
      - name: wtmp
        path: /var/log/wtmp
        missingok: true
        frequency: monthly
        create: true
        create_mode: "0664"
        create_user: root
        create_group: utmp
        minsize: 1M
        maxsize: 128M
        dateext: true
        dateformat: "-%Y%m%d"
        keep: 1
      - name: dnf
        path: /var/log/hawkey.log
        missingok: true
        notifempty: true
        keep: 4
        frequency: weekly
        create: true
      - name: example-sharedscripts
        path: "/var/log/example-sharedscripts/*.log"
        sharedscripts: true
      - name: example-dateyesterday
        state: present
        path: "/var/log/example-dateyesterday/*.log"
        dateyesterday: true
      - name: example-absent
        state: absent
        # Negative numbers work on some distributions: `error: example-negative:10 bad rotation count '-1'\`
        # - name: example-negative
        #   path: "/var/log/example-keep-negative/*.log"
        #   keep: -1

  roles:
    - role: buluma.logrotate
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-logrotate/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.cron

  post_tasks:
    - name: Create log directory
      ansible.builtin.file:
        path: "{{ item }}"
        state: directory
        mode: "0755"
      loop:
        - /var/log/example
        - /var/log/example-frequency
        - /var/log/example-keep
        - /var/log/example-compress
        - /var/log/example-copylog
        - /var/log/example-copytruncate
        - /var/log/example-delaycompress
        - /var/log/example-script
        - /var/log/example-sharedscripts
        - /var/log/example-dateyesterday

    - name: Create log file
      ansible.builtin.copy:
        dest: "{{ item }}"
        content: "example"
        mode: "0644"
      loop:
        - /var/log/example/app.log
        - /var/log/example-frequency/app.log
        - /var/log/example-keep/app.log
        - /var/log/example-compress/app.log
        - /var/log/example-copylog/app.log
        - /var/log/example-copytruncate/app.log
        - /var/log/example-delaycompress/app.log
        - /var/log/example-script/app.log
        - /var/log/example-sharedscripts/app.log
        - /var/log/example-dateyesterday/app.log
        - /var/log/btmp
        - /var/log/wtmp
        - /var/log/hawkey.log
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-logrotate/blob/master/defaults/main.yml):

```yaml
---
# defaults file for logrotate

# How often to rotate logs, either daily, weekly or monthly.
logrotate_frequency: weekly

# How many files to keep.
logrotate_keep: 4

# Should rotated logs be compressed??
logrotate_compress: true

# Use date extension on log file names
logrotate_dateext: false

# User/Group for rotated log files (Loaded by OS-Specific vars if found, or and can be set manually)
logrotate_user: "{{ _logrotate_user[ansible_facts['distribution']] | default(_logrotate_user['default']) }}"
logrotate_group: "{{ _logrotate_group[ansible_facts['distribution']] | default(_logrotate_group['default']) }}"

# Set the state of the service
logrotate_service_state: "started"
logrotate_service_enabled: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-logrotate/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-logrotate/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-logrotate/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-logrotate/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
