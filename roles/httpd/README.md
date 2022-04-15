# [httpd](#httpd)

Install and configure httpd on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-httpd/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-httpd)|[![quality](https://img.shields.io/ansible/quality/57924)](https://galaxy.ansible.com/buluma/httpd)|[![downloads](https://img.shields.io/ansible/role/d/57924)](https://galaxy.ansible.com/buluma/httpd)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-httpd.svg)](https://github.com/buluma/ansible-role-httpd/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  vars_files:
    - ../../vars/main.yml
    - ../../defaults/main.yml

  roles:
    - role: buluma.httpd
      # https_ssl_enable: yes
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
      #     create_docroot: no
      httpd_directories:
        - name: my_directory
          path: "{{ httpd_data_directory }}/my_directory"
          # options:
          #   - Indexes
          #   - FollowSymLinks
          allow_override: All
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
    - role: buluma.buildtools
    - role: buluma.python_pip
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_fqdn }}"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for httpd

# The servername to use.
httpd_servername: "{{ ansible_fqdn }}"

# The non-SSL port to use.
httpd_port: 80

# Enable (self-signed certificates) SSL?
https_ssl_enable: no

# To configure https, set the hostname to listen to.
httpd_ssl_servername: "{{ ansible_fqdn }}"

# For SSL a TCP port is required.
httpd_ssl_port: 443

# SSL Certificate:
httpd_openssl_crt: "{{ httpd_openssl_crt_directory }}/apache-httpd.crt"

# SSL Key
httpd_openssl_key: "{{ httpd_openssl_key_directory }}/apache-httpd.key"

# If the "it works" page should be kept
httpd_remove_example: no
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-httpd/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openssl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openssl)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-selinux/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-httpd/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Alpine | ImportError: Error loading shared library /tmp/pip-build-env-23ZqyN/lib/python2.7/site-packages/_cffi_backend.so: Operation not permitted |
| amazonlinux | Dependency (python_pip) not available. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-httpd/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
