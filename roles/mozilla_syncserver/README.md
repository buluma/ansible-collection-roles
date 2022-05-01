# [mozilla_syncserver](#mozilla_syncserver)

A deployment role for Mozilla's Firefox Sync server.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-mozilla_syncserver/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-mozilla_syncserver/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mozilla_syncserver)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/mozilla_syncserver)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/mozilla_syncserver)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mozilla_syncserver.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mozilla_syncserver.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mozilla_syncserver.svg)](https://github.com/buluma/ansible-role-mozilla_syncserver/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include ansible-mozilla-syncserver"
      include_role:
        name: "buluma.mozilla_syncserver"
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  pre_tasks:
    - name: Update the apt-cache, if necessary
      apt:
        update_cache: true
        cache_valid_time: 86400
      when: ansible_facts['os_family'] == 'Debian'
  roles:
    # - buluma.docker
    - buluma.setuptools
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# What version of the mozilla/syncserver docker image should we
# install?
# https://hub.docker.com/r/mozilla/syncserver
mozilla_syncserver_docker_version: latest

# A list of additional volumes to mount into the docker container.  This is
# useful for things like SSL certificates and custom css/image assets.
mozilla_syncserver_additional_volumes: []
# - "/some/directory:/some/mount:ro"
# - "/some/file.yml:/some/mount/file.yml:ro"

mozilla_syncserver_port: "5000"

# A key/value set of environment variables and their values, which will be
# set on the docker container.
mozilla_syncserver_environment_variables:
  SYNCSERVER_PUBLIC_URL: "http://localhost:{{ mozilla_syncserver_port }}"
  SYNCSERVER_SECRET: "<PUT YOUR SECRET KEY HERE>"
  SYNCSERVER_SQLURI: "sqlite:////data/syncserver.db"
  SYNCSERVER_BATCH_UPLOAD_ENABLED: "true"
  SYNCSERVER_FORCE_WSGI_ENVIRON: "false"
  PORT: "{{ mozilla_syncserver_port }}"

# If set to a string, the created Docker container will attach to a
# pre-existing default Docker network, instead of creating its own.
mozilla_syncserver_network_name: ""

# Labels to put on the application containers
mozilla_syncserver_container_labels: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.setuptools](https://galaxy.ansible.com/buluma/setuptools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-setuptools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-setuptools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-setuptools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-setuptools)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mozilla_syncserver/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-mozilla_syncserver/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-mozilla_syncserver/blob/master/CHANGELOG.md)

## [License](#license)

MIT

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
