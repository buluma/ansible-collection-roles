# [Ansible role redmine-1](#ansible-role-redmine-1)

Install Redmine on CentOS

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-redmine-1/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-redmine-1/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-redmine-1.svg)](https://github.com/buluma/ansible-role-redmine-1/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-redmine-1.svg)](https://github.com/buluma/ansible-role-redmine-1/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-redmine-1.svg)](https://github.com/buluma/ansible-role-redmine-1/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/redmine-1)](https://galaxy.ansible.com/ui/standalone/roles/buluma/redmine-1/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-redmine-1/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  vars:
    - centos_base_enable_epel: true
    - centos_base_fail2ban_configuration: false
    - centos_base_install_selinux_packages: true
    - centos_base_basic_packages: true
    - centos_base_security_packages: true
    - centos_base_firewalld: true
    - ruby_version: 2.3
    - ruby_install_globally: true
  roles:
    # - buluma.centos_base
    - bngsudheer.ruby
    # - buluma.ruby

- name: Converge
  hosts: all
  vars:
    - redmine_sql_database_name: "redmine"
    - redmine_sql_database_host: "localhost"
    - redmine_sql_username: "redmine"
    - redmine_sql_password: "password"
    - redmine_unicorn_port: 5777
    - redmine_configure_selinux: false
    - redmine_plugins:
        - name: scrum
          base_name: scrum
          url: https://redmine.ociotec.com/attachments/download/481/scrum-v0.18.1.tar.gz
          create_base_directory: false
        - name: timesheet
          base_name: timesheet
          url: https://github.com/Contargo/redmine-timesheet-plugin/archive/master.zip
          create_base_directory: false
    - mysql_databases:
        - name: redmine
    - mysql_users:
        - name: redmine
          password: password
          priv: "redmine.*:ALL"
    - redmine_additional_configuration: true
    - redmine_enable_smtp_email: true
    - redmine_smtp_settings_address: localhost
    - redmine_smtp_settings_port: 25
    - redmine_smtp_settings_authentication: plain
    - redmine_smtp_settings_domain: redmine.example.com
    - redmine_smtp_settings_user_name: redmine@redmine.example.com
    - redmine_smtp_settings_password: password
    - redmine_smtp_settings_enable_starttls_auto: true
  roles:
    # - buluma.mysql
    - buluma.redmine
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-redmine-1/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.epel
    - role: buluma.centos_base
    - role: bngsudheer.ruby
    - role: buluma.nginx
    - role: buluma.mysql
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-redmine-1/blob/master/defaults/main.yml):

```yaml
---
# defaults file for ansible-role-redmine
redmine_version: "3.4.11"
# redmine_runtime_directory: "/home/redmine/redmine-{{ redmine_version }}"
redmine_runtime_directory: "/srv/redmine/redmine"

redmine_sql_driver: "mysql2"
redmine_sql_database_name: "redmine"
redmine_sql_database_host: "localhost"
redmine_sql_username: "redmine"
redmine_sql_password: "password"

redmine_unicorn_worker_processes: 2

redmine_domain_name: redmine.example.com

redmine_configure_nginx: true
redmine_nginx_config_template: plain
redmine_nginx_custom_config_path:
redmine_configure_unicorn: true
redmine_configure_firewalld: true

redmine_unicorn_port: 5000
redmine_nginx_bind_ip:
redmine_plugins: []
redmine_configure_selinux: false
redmine_bundler_version: "1.16.1"

redmine_additional_configuration: false
redmine_enable_smtp_email: false
redmine_smtp_settings_address: localhost
redmine_smtp_settings_port: "25"
redmine_smtp_settings_authentication: plain
redmine_smtp_settings_domain: redmine.example.com
redmine_smtp_settings_user_name:
redmine_smtp_settings_password:
redmine_smtp_settings_enable_starttls_auto: false

redmine_default_data: false
redmine_language: en
redmine_ssl_certificate_path: "/etc/letsencrypt/live/{{ redmine_domain_name }}/fullchain.pem"
redmine_ssl_certificate_key_path: "/etc/letsencrypt/live/{{ redmine_domain_name }}/privkey.pem"
redmine_nginx_allowlist: false
redmine_nginx_allowlist_path: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-redmine-1/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.centos_base](https://galaxy.ansible.com/buluma/centos_base)|[![Build Status GitHub](https://github.com/buluma/ansible-role-centos_base/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-centos_base/actions)|
|[bngsudheer.ruby](https://galaxy.ansible.com/buluma/bngsudheer.ruby)|[![Build Status GitHub](https://github.com/buluma/bngsudheer.ruby/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/bngsudheer.ruby/actions)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|
|[buluma.nginx](https://galaxy.ansible.com/buluma/nginx)|[![Build Status GitHub](https://github.com/buluma/ansible-role-nginx/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nginx/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-redmine-1/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-redmine-1/issues).

## [License](#license)

[license (Apache-2.0)](https://github.com/buluma/ansible-role-redmine-1/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
