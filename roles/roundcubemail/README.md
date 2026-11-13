# [Ansible role roundcubemail](#ansible-role-roundcubemail)

Install and configure roundcubemail on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-roundcubemail/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-roundcubemail/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-roundcubemail.svg)](https://github.com/buluma/ansible-role-roundcubemail/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-roundcubemail.svg)](https://github.com/buluma/ansible-role-roundcubemail/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-roundcubemail.svg)](https://github.com/buluma/ansible-role-roundcubemail/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/roundcubemail)](https://galaxy.ansible.com/ui/standalone/roles/buluma/roundcubemail/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-roundcubemail/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  vars_files: ../../vars/main.yml

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_facts['os_family'] == 'Debian'
      changed_when: false

  roles:
    - role: buluma.httpd
      httpd_vhosts:
        - name: docroot
          servername: roundcubemail.example.com
          documentroot: "{{ roundcubemail_install_directory }}"
    - role: buluma.roundcubemail
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-roundcubemail/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.buildtools
    - role: buluma.python_pip
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_facts['fqdn'] }}"
    - role: buluma.selinux
    - role: buluma.httpd
    - role: buluma.php
      php_upload_max_filesize: 5M
      php_post_max_size: 6M
      php_date_timezone: Europe/Amsterdam
      php_extension:
        - mcrypt.so
    - role: buluma.mysql
      mysql_databases:
        - name: roundcube
      mysql_users:
        - name: roundcube
          password: roundcube
          priv: "roundcube.*:ALL"
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-roundcubemail/blob/master/defaults/main.yml):

```yaml
---
# defaults file for roundcubemail

roundcubemail_database_host: localhost
roundcubemail_database_user: roundcube
roundcubemail_database_password: roundcube
roundcubemail_database_name: roundcube

# A URL to get support.
roundcubemail_support_url: "{{ ansible_facts['fqdn'] }}/support"

# A key to encrypt sensitive data.
roundcubemail_des_key: 964af56991531a805bd55085

# The spellchecker to use. Either: 'google', 'pspell', 'enchant' or 'atd'.
roundcubemail_spellcheck_engine: pspell

# The mail host chosen to perform the log-in.
roundcubemail_default_host: localhost
roundcubemail_default_port: 143

# SMTP server host (for sending mails).
roundcubemail_smtp_server: localhost
roundcubemail_smtp_port: 25
roundcubemail_smtp_user: ""
roundcubemail_smtp_pass: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-roundcubemail/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.php](https://galaxy.ansible.com/buluma/php)|[![Build Status GitHub](https://github.com/buluma/ansible-role-php/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-php/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.reboot](https://galaxy.ansible.com/buluma/reboot)|[![Build Status GitHub](https://github.com/buluma/ansible-role-reboot/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-reboot/actions)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- {'role': 'buluma.httpd'}

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-roundcubemail/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|bookworm, trixie|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|noble, jammy|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-roundcubemail/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-roundcubemail/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
