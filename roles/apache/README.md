# [apache](#apache)

Apache 2.x for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-apache/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apache)|[![quality](https://img.shields.io/ansible/quality/54595)](https://galaxy.ansible.com/buluma/apache)|[![downloads](https://img.shields.io/ansible/role/d/54595)](https://galaxy.ansible.com/buluma/apache)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-apache.svg)](https://github.com/buluma/ansible-role-apache/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-apache.svg)](https://github.com/buluma/ansible-role-apache/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-apache.svg)](https://github.com/buluma/ansible-role-apache/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    apache_listen_port_ssl: 443
    apache_create_vhosts: true
    apache_vhosts_filename: "vhosts.conf"
    apache_vhosts:
      - servername: "example.com"
        documentroot: "/var/www/vhosts/example_com"

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.apache
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
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-apache/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-apache/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|all|
|amazon|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-apache/issues)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
