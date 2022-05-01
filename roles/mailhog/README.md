# [mailhog](#mailhog)

MailHog for Linux

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-mailhog/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mailhog/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-mailhog/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mailhog)|[![quality](https://img.shields.io/ansible/quality/55009)](https://galaxy.ansible.com/buluma/mailhog)|[![downloads](https://img.shields.io/ansible/role/d/55009)](https://galaxy.ansible.com/buluma/mailhog)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-mailhog.svg)](https://github.com/buluma/ansible-role-mailhog/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-mailhog.svg)](https://github.com/buluma/ansible-role-mailhog/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-mailhog.svg)](https://github.com/buluma/ansible-role-mailhog/pulls/)|

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

    - name: Ensure build dependencies are installed (RedHat).
      package:
        name:
          - "@Development tools"
          - tar
          - unzip
          - net-tools
          - curl
        state: present
      when: ansible_os_family == 'RedHat'

    - name: Ensure build dependencies are installed (Debian).
      apt:
        name:
          - build-essential
          - tar
          - unzip
          - net-tools
          - curl
        state: present
      when: ansible_os_family == 'Debian'

  roles:
    - geerlingguy.daemonize
    - buluma.mailhog

  post_tasks:
    - name: Copy test message into place.
      copy:
        src: test-message
        dest: /tmp/test-message
        mode: 0644

    - name: Send an email via mhsendmail.
      shell: cat /tmp/test-message | /opt/mailhog/mhsendmail johndoe@example.com
      changed_when: false

    - name: Test retrieiving messages from the MailHog API.
      uri:
        url: http://localhost:8025/api/v2/messages
      register: result
      until: result.status == 200
      retries: 60
      delay: 1
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
mailhog_install_dir: /opt/mailhog
mailhog_version: 1.0.0
mailhog_binary_url: "https://github.com/mailhog/MailHog/releases/download/v{{ mailhog_version }}/MailHog_linux_amd64"
mhsendmail_version: 0.2.0
mhsendmail_binary_url: "https://github.com/mailhog/mhsendmail/releases/download/v{{ mhsendmail_version }}/mhsendmail_linux_amd64"

# Path to daemonize, which is used to launch MailHog via init script.
mailhog_daemonize_bin_path: /usr/sbin/daemonize
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-mailhog/blob/main/requirements.txt).


## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- geerlingguy.daemonize
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-mailhog/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-mailhog/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-mailhog/blob/master/CHANGELOG.md)

## [License](#license)

license (BSD, MIT)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
