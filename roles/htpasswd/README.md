# [htpasswd](#htpasswd)

htpasswd installation and helper role for Linux servers.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-htpasswd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-htpasswd/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-htpasswd/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-htpasswd)|[![quality](https://img.shields.io/ansible/quality/58768)](https://galaxy.ansible.com/buluma/htpasswd)|[![downloads](https://img.shields.io/ansible/role/d/58768)](https://galaxy.ansible.com/buluma/htpasswd)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-htpasswd.svg)](https://github.com/buluma/ansible-role-htpasswd/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-htpasswd.svg)](https://github.com/buluma/ansible-role-htpasswd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-htpasswd.svg)](https://github.com/buluma/ansible-role-htpasswd/pulls/)|

## [Example Playbook](#example-playbook)

### Apache Example

```yaml
---
- hosts: apache-server

  vars:
    htpasswd_credentials:
      - path: /etc/apache-passwdfile
        name: johndoe
        password: 'supersecure'
        owner: root
        group: apache
        mode: 'u+rw,g+r'

    apache_remove_default_vhost: True
    apache_vhosts:
      - listen: "80"
        servername: "htpassword.test"
        documentroot: "/var/www/html"
        extra_parameters: |
              <Directory "/var/www/html">
                  AuthType Basic
                  AuthName "Apache with basic auth."
                  AuthUserFile /etc/apache-passwdfile
                  Require valid-user
              </Directory>

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - buluma.bootstrap
    - buluma.nginx
    - buluma.htpasswd
```

### Nginx Example

```yaml
---
- hosts: nginx-server

  vars:
    htpasswd_credentials:
      - path: /etc/nginx/passwdfile
        name: johndoe
        password: 'supersecure'
        owner: root
        group: www-data
        mode: 'u+rw,g+r'

    nginx_remove_default_vhost: True
    nginx_vhosts:
      - listen: "80"
        server_name: "htpassword.test"
        root: "/var/www/html"
        index: "index.html index.html index.nginx-debian.html"
        filename: "htpassword.test.conf"
        extra_parameters: |
              location / {
                  auth_basic           "Nginx with basic auth.";
                  auth_basic_user_file /etc/nginx/passwdfile;
              }

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'

  roles:
    - buluma.bootstrap
    - buluma.nginx
    - buluma.htpasswd
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Define this variable if you'd like to override the defaults.
# htpasswd_required_packages: []

# Whether to show htpasswd credentials in Ansible's log output.
htpasswd_nolog: true

# A list of htpasswd credentials.
htpasswd_credentials: []
# - path: /etc/nginx/passwdfile
#   name: johndoe
#   password: 'supersecure'
#   owner: root
#   group: www-data
#   mode: 0640

# - path: /etc/apache2/passwdfile
#   name: janedoe
#   password: 'supersecure'
#   owner: root
#   group: www-data
#   mode: 0640
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-htpasswd/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.apache](https://galaxy.ansible.com/buluma/apache)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apache/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apache)|
|[buluma.nginx](https://galaxy.ansible.com/buluma/nginx)|[![Build Status GitHub](https://github.com/buluma/ansible-role-nginx/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nginx/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-nginx/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nginx)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-htpasswd/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|
|fedora|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-htpasswd/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
