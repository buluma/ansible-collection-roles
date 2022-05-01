# [multi](#multi)

Apache 2.x for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-multi/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-multi/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-multi/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-multi)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/multi)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/multi)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-multi.svg)](https://github.com/buluma/ansible-role-multi/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-multi.svg)](https://github.com/buluma/ansible-role-multi/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-multi.svg)](https://github.com/buluma/ansible-role-multi/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true
  strategy: free

  vars:
    users:
    alice:
      name: Alice Appleworth
      telephone: 123-456-7890
    bob:
      name: Bob Bananarama
      telephone: 987-654-3210
    _service_test_command:
      default: /usr/bin/sleep
      Alpine: /bin/sleep
      Debian: /bin/sleep
      Ubuntu-16: /bin/sleep
      Ubuntu-18: /bin/sleep
    service_test_command: "{{ _service_test_command[ansible_distribution ~ '-' ~ ansible_distribution_major_version] | default(_service_test_command[ansible_os_family] | default(_service_test_command['default'])) }}"  # noqa 204 Just long.


  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.multi  # Main
    # - role: buluma.apache
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    # - role: buluma.bootstrap
    - role: buluma.systemd
    - role: buluma.core_dependencies
    # - role: buluma.cron
    # - role: buluma.service
    # - role: buluma.python_pip
    # - role: buluma.reboot
    # - role: buluma.gitlab
    # - role: buluma.apache
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
apache_enablerepo: ""

apache_listen_ip: "*"
apache_listen_port: 80
apache_listen_port_ssl: 443

apache_create_vhosts: true
apache_vhosts_filename: "vhosts.conf"
apache_vhosts_template: "vhosts.conf.j2"

# On Debian/Ubuntu, a default virtualhost is included in Apache's configuration.
# Set this to `true` to remove that default.
apache_remove_default_vhost: false

apache_global_vhost_settings: |
  DirectoryIndex index.php index.html

apache_vhosts:
  # Additional properties:
  # 'serveradmin, serveralias, allow_override, options, extra_parameters'.
  - servername: "local.dev"
    documentroot: "/var/www/html"

apache_allow_override: "All"
apache_options: "-Indexes +FollowSymLinks"

apache_vhosts_ssl: []
# Additional properties:
# 'serveradmin, serveralias, allow_override, options, extra_parameters'.
# - servername: "local.dev",
#   documentroot: "/var/www/html",
#   certificate_file: "/path/to/certificate.crt",
#   certificate_key_file: "/path/to/certificate.key",
#   # Optional.
#   certificate_chain_file: "/path/to/certificate_chain.crt"

apache_ignore_missing_ssl_certificate: true

apache_ssl_protocol: "All -SSLv2 -SSLv3"
apache_ssl_cipher_suite: "AES256+EECDH:AES256+EDH"

# Only used on Debian/Ubuntu.
apache_mods_enabled:
  - rewrite.load
  - ssl.load
apache_mods_disabled: []

# Set initial apache state. Recommended values: `started` or `stopped`
apache_state: started

# Set initial apache service status. Recommended values: `yes` or `no`
apache_enabled: yes

# Set apache state when configuration changes are made. Recommended values:
# `restarted` or `reloaded`
apache_restart_state: restarted

# Apache package state; use `present` to make sure it's installed, or `latest`
# if you want to upgrade or switch versions using a new repo.
apache_packages_state: present

ip_from_ec2: "10.0.0.1"

new_ip: "10.0.0.3"

new_port: 8081

apt_autostart_state: enabled

# defaults file for reboot

# Some operating systems can determine if a reboot is required. This
# parameter can be set to always reboot.
reboot_always: yes

# How long to wait before sending a reboot.
reboot_delay: 5

# Number of seconds to wait before checking if the machine is up.
reboot_up_delay: 10

# You can specify a message for rebooting, easier for auditing.
reboot_message: "Ansible role buluma.reboot initiated a reboot."


# defaults file for users

# The location to store ssh keys for user
users_ssh_key_directory: ssh_keys

# The default shell if not overwritten.
users_shell: /bin/bash

# manage cron permissions via /etc/cron.allow
users_cron_allow: yes

# should homedirectories be created?
users_create_home: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-multi/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.apache](https://galaxy.ansible.com/buluma/apache)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apache/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apache)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|
|[buluma.systemd](https://galaxy.ansible.com/buluma/systemd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-systemd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-systemd/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-systemd/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-systemd)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.reboot](https://galaxy.ansible.com/buluma/reboot)|[![Build Status GitHub](https://github.com/buluma/ansible-role-reboot/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-reboot/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-reboot/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-reboot)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-multi/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-multi/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-multi/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
