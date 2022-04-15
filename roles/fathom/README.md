# [fathom](#fathom)

Fathom web analytics

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-fathom/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-fathom/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-fathom/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-fathom)|[![quality](https://img.shields.io/ansible/quality/54560)](https://galaxy.ansible.com/buluma/fathom)|[![downloads](https://img.shields.io/ansible/role/d/54560)](https://galaxy.ansible.com/buluma/fathom)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-fathom.svg)](https://github.com/buluma/ansible-role-fathom/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-fathom.svg)](https://github.com/buluma/ansible-role-fathom/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-fathom.svg)](https://github.com/buluma/ansible-role-fathom/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.fathom

  post_tasks:
    - name: Ensure Fathom is responding on the specified port.
      uri:
        url: "http://127.0.0.1:{{ fathom_http_port }}"
        status_code: 200
      register: result
      until: result.status == 200
      retries: 60
      delay: 1
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for fathom
fathom_binary_url: https://github.com/usefathom/fathom/releases/download/v1.2.1/fathom_1.2.1_linux_amd64.tar.gz
fathom_force_update: false

fathom_manage_service: true
fathom_service_state: started
fathom_service_enabled: true
fathom_service_user: root

fathom_directory: /opt/fathom
fathom_http_port: "9000"
fathom_database_name: fathom.db
fathom_secret: secret-string-here
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-fathom/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.repo_epel](https://galaxy.ansible.com/buluma/repo_epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-repo_epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-repo_epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-repo_epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-repo_epel)|
|[buluma.nginx](https://galaxy.ansible.com/buluma/nginx)|[![Build Status GitHub](https://github.com/buluma/ansible-role-nginx/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nginx/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-nginx/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nginx)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-fathom/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-fathom/issues)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
