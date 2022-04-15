# [nginx](#nginx)

Install and configure nginx on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-nginx/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nginx/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nginx/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nginx)|[![quality](https://img.shields.io/ansible/quality/54561)](https://galaxy.ansible.com/buluma/nginx)|[![downloads](https://img.shields.io/ansible/role/d/54561)](https://galaxy.ansible.com/buluma/nginx)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nginx.svg)](https://github.com/buluma/ansible-role-nginx/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nginx.svg)](https://github.com/buluma/ansible-role-nginx/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nginx.svg)](https://github.com/buluma/ansible-role-nginx/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.nginx
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for nginx

# The tcp port nginx should listen on.
nginx_port: 80
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nginx/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nginx/png/requirements.png "Dependencies")

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
| Alpine | can't create /sys/fs/cgroup/systemd/tasks: Read-only file system |
| amazonlinux:1 | etc/init.d/nginx: line 17: /etc/sysconfig/network: No such file or directory |
| centos:7 | Package: 1:nginx Requires: libprofiler.so.0 |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nginx/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
