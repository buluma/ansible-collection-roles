# [Ansible role httpd](#ansible-role-httpd)

Install and configure httpd on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-httpd/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-httpd.svg)](https://github.com/buluma/ansible-role-httpd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-httpd.svg)](https://github.com/buluma/ansible-role-httpd/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-httpd.svg)](https://github.com/buluma/ansible-role-httpd/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/httpd)](https://galaxy.ansible.com/ui/standalone/roles/buluma/httpd/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-httpd/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  vars_files:
    - ../../vars/main.yml
    - ../../defaults/main.yml

  pre_tasks:
    - name: Update apt cache.
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 600
      when: ansible_facts['os_family'] == 'Debian'
      changed_when: false

    - name: Check if python3.11 EXTERNALLY-MANAGED file exists
      ansible.builtin.stat:
        path: /usr/lib/python3.11/EXTERNALLY-MANAGED
      register: externally_managed_file_py311

    - name: Rename python3.11 EXTERNALLY-MANAGED file if it exists
      ansible.builtin.command:
        cmd: mv /usr/lib/python3.11/EXTERNALLY-MANAGED
          /usr/lib/python3.11/EXTERNALLY-MANAGED.old
      when: externally_managed_file_py311.stat.exists
      args:
        creates: /usr/lib/python3.11/EXTERNALLY-MANAGED.old

    - name: Check if python3.12 EXTERNALLY-MANAGED file exists
      ansible.builtin.stat:
        path: /usr/lib/python3.12/EXTERNALLY-MANAGED
      register: externally_managed_file_py312

    - name: Rename python3.12 EXTERNALLY-MANAGED file if it exists
      ansible.builtin.command:
        cmd: mv /usr/lib/python3.12/EXTERNALLY-MANAGED
          /usr/lib/python3.12/EXTERNALLY-MANAGED.old
      when: externally_managed_file_py312.stat.exists
      args:
        creates: /usr/lib/python3.12/EXTERNALLY-MANAGED.old

  roles:
    - role:
        buluma.httpd
        # https_ssl_enable: true
      httpd_port: 8080
      httpd_ssl_port: 8443
      httpd_locations:
        - name: my_location
          location: /my_location
          backend_url: "http://localhost:8080/myapplication"
          # httpd_vhosts:
          #   - name: my_vhost_docroot
          #     servername: www1.example.com
          #     documentroot: "{{ httpd_data_directory }}/www1.example.com"
          #   - name: my_vhost_backend_http
          #     servername: www2.example.com
          #     backend_url: "http://www.example.com/"
          #     serveralias:
          #       - example.com
          #       - www.example.com
          #   - name: my_vhost_remote
          #     servername: www3.example.com
          #     remote: "http://localhost:3128/"
          #   - name: my_vhost_backend_https
          #     servername: www4.example.com
          #     backend_url: "https://www.example.com/"
          #   - name: my_vhost_piratebay
          #     servername: piratebay.nl
          #     backend_url: "https://thepirate-bay.org/"
          #     proxy_preserve_host: Off
          #     proxy_requests: Off
          #     setenv:
          #       - name: force-proxy-request-1.0
          #         value: 1
          #       - name: proxy-nokeepalive
          #         value: 1
          #       - name: proxy-initial-not-pooled
          #       - name: proxy-sendchunks
          #         value: 1
          #   - name: no_doc_root
          #     servername: nodocroot.example.com
          #     documentroot: /var/www/html/nodocroot
          #     create_docroot: false
      httpd_directories:
        - name: my_directory
          path:
            "{{ httpd_data_directory }}/my_directory"
            # options:
            #   - Indexes
            #   - FollowSymLinks
          allow_override: All
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-httpd/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.openssl
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-httpd/blob/master/defaults/main.yml):

```yaml
---
# defaults file for httpd

# The servername to use.
httpd_servername: "{{ ansible_facts['fqdn'] }}"

# The non-SSL port to use.
httpd_port: 80

# Enable (self-signed certificates) SSL?
https_ssl_enable: false

# To configure https, set the hostname to listen to.
httpd_ssl_servername: "{{ ansible_facts['fqdn'] }}"

# For SSL a TCP port is required.
httpd_ssl_port: 443

# SSL Certificate:
httpd_openssl_crt: "{{ httpd_openssl_crt_directory }}/apache-httpd.crt"

# SSL Key
httpd_openssl_key: "{{ httpd_openssl_key_directory }}/apache-httpd.key"

# If the "it works" page should be kept
httpd_remove_example: false

# Additionnal httpd module to install

httpd_additionnal_modules: []
httpd_custom_modules_to_activate_with_command: []
apache_global_vhost_settings: |
  DirectoryIndex index.php index.html

# Template to uses for vhosts. Usefull to override the conf by your own setup.
vhost_conf_template: vhost.conf.j2

default_vhost_conf: default_vhost.conf
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-httpd/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-httpd/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-httpd/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-httpd/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
