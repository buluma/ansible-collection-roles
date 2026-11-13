# [Ansible role rsyslog](#ansible-role-rsyslog)

Install and configure rsyslog on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-rsyslog/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-rsyslog/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-rsyslog.svg)](https://github.com/buluma/ansible-role-rsyslog/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-rsyslog.svg)](https://github.com/buluma/ansible-role-rsyslog/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-rsyslog.svg)](https://github.com/buluma/ansible-role-rsyslog/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/rsyslog)](https://galaxy.ansible.com/ui/standalone/roles/buluma/rsyslog/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-rsyslog/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.rsyslog
      vars:
        rsyslog_traditional_file_format: false
        rsyslog_omit_local_logging: false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-rsyslog/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-rsyslog/blob/master/defaults/main.yml):

```yaml
---
# defaults file for rsyslog

# To configure a server to receive logs, set rsyslog_receiver to true.
rsyslog_receiver: false

# To forward logs to another server, set rsyslog_remote to the hostname or
# the ipaddress of the receiving rsyslog server.
# Not setting this variable will not forward logs.
# rsyslog_remote: server1.example.com

# If rsylog_remote is set, sets the "selector" pattern for determining which
# messages to send to the remote server.  Default "*.*" sends everything.
# See `man rsyslog.conf`.
rsyslog_remote_selector: "*.*"

# If rsylog_remote is set, use TCP if true. UDP if false.
rsyslog_remote_tcp: true

# If rsylog_remote is set, destination port to use.
rsyslog_remote_port: 514

# Set the mode for new directories; only available in legacy template.
rsyslog_dircreatemode: "0700"

# Set the mode for new files; only available in legacy template.
rsyslog_filecreatemode: "0644"

# Set the mods enabled
rsyslog_mods:
  - imuxsock
  - imjournal

# Configure rsyslog minimally (may be in conflict with custom configuration files)
rsyslog_deploy_default_config: true

# Default rsyslogd rules
rsyslog_default_rules:
  - rule: "*.info;mail.none;authpriv.none;cron.none"
    logpath: "/var/log/messages"
  - { rule: "authpriv.*", logpath: "/var/log/secure" }
  - { rule: "mail.*", logpath: "-/var/log/maillog" }
  - { rule: "cron.*", logpath: "/var/log/cron" }
  - { rule: "*.emerg", logpath: ":omusrmsg:*" }
  - { rule: "uucp,news.crit", logpath: "/var/log/spooler" }
  - { rule: "local7.*", logpath: "/var/log/boot.log" }

# Use the (obsolete) legacy, pre-v6 configuration file format, or the more
# modern # 'advanced' configuration file format available in v6 and up. The
# default is to use the 'legacy' format to not change config files for
# existing users of this role out of the blue.
# More information on the different formats on the rsyslog website:
# https://www.rsyslog.com/doc/v8-stable/configuration/conf_formats.html
rsyslog_config_file_format: legacy

# The rule conf to name to add to /etc/rsyslog.d/
# rsyslog_forward_rule_name: <to fill>

# Configure the rsyslog package to be `present`, or set to `latest` to install
# the latest available version.
rsyslog_package_state: present

# if set to false (legacy default to remain compatible to sysklogd), the domain
# part from a name that is within the same domain as the receiving system is
# stripped. If set to on, full names are always used.
rsyslog_preservefqdn: false

# Configure additional config files in /etc/rsyslog.d
# Example:
# rsyslog_rsyslog_d_files:
#   000-splunk:
#     content: |
#       auth,authpriv.* action(type="omfwd"
#                              target="splunk"
#                              port="514"
#                              protocol="tcp")
rsyslog_rsyslog_d_files: []
# Avoid sd_journal_get_cursor() failed: Cannot assign requested address messages
# due to logrotate
rsyslog_workaroundjournalbug: false

# Turns off message reception via local log socket
rsyslog_imuxsock_syssock: false

# Install additional rsyslog packages
# Example for installing rsyslog-elastisearch:
# rsyslog_features:
#   - gnutls
#   - elastisearch
rsyslog_features: []
# Default destination of rsyslog config file
rsyslog_dest_conf_file: "/etc/rsyslog.conf"

# Enable / Disable option OmitLocalLogging
rsyslog_omit_local_logging: true

# Allow using the traditional file format.
rsyslog_traditional_file_format: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-rsyslog/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-rsyslog/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-rsyslog/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-rsyslog/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
