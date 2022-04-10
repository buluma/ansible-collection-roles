# [sentry](#sentry)

Sentry installation with Python.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-sentry/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sentry/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-sentry/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sentry)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/sentry)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/sentry)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-sentry.svg)](https://github.com/buluma/ansible-role-sentry/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-sentry.svg)](https://github.com/buluma/ansible-role-sentry/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-sentry.svg)](https://github.com/buluma/ansible-role-sentry/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.sentry
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
sentry_version: '9.0.0'
sentry_install_dir: '/srv/sentry'
sentry_system_user: 'sentry'
sentry_system_group: 'sentry'
sentry_system_cron_hour: 3
sentry_system_cron_minute: 0
sentry_extra_pip_packages: []

# config.yml settigs
sentry_mail_backend: 'dummy'
sentry_mail_host: 'localhost'
sentry_mail_port: 25
sentry_mail_username: ''
sentry_mail_password: ''
sentry_mail_use_tls: false
sentry_mail_from: 'root@localhost'
sentry_mail_enable_replies: false
sentry_mail_reply_hostname: ''
sentry_mail_mailgun_api_key: ''

sentry_secret_key: 'UNSAFE'
sentry_url_prefix: ''

sentry_redis_clusters:
  default:
    hosts:
      0:
        host: 127.0.0.1
        port: 6379

sentry_filestore_backend: 'filesystem'
sentry_filestore_options:
  location: '/tmp/sentry-files'

# sentry.conf.py settings
sentry_db_name: 'sentry'
sentry_db_user: 'sentry'
sentry_db_password: ''
sentry_db_host: ''
sentry_db_port: ''
sentry_broker_url: 'redis://localhost:6379'
sentry_behind_ssl_proxy: false
sentry_web_host: '0.0.0.0'
sentry_web_port: 9000
sentry_auth_register: true
# Extra configuration options, should be valid Python code
sentry_extra_conf_py: ''

# Cleanup
sentry_schedule_cleanup: true
sentry_cleanup_days: 30
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-sentry/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-sentry/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|bionic|
|el|7|
|debian|all|

The minimum version of Ansible required is 2.7, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-sentry/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
