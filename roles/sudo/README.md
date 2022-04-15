# [sudo](#sudo)

Install sudo on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-sudo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sudo/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-sudo/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sudo)|[![quality](https://img.shields.io/ansible/quality/58376)](https://galaxy.ansible.com/buluma/sudo)|[![downloads](https://img.shields.io/ansible/role/d/58376)](https://galaxy.ansible.com/buluma/sudo)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-sudo.svg)](https://github.com/buluma/ansible-role-sudo/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  # This role installs packages using the `raw` module and needs to connect as
  # `root`. (`sudo` is not available before sudo-ing.) All tasks in the
  # role have `become` set to `no`, so you can use either `no` or `yes` for
  # `become`, the role will not use become (so `sudo`) for any task.
  become: yes  # `no` will also work.
  # This role installs sudo, gathering facts can't be done before `sudo` is
  # installed. This role runs the `setup` module, so facts will be available
  # after running the role.
  gather_facts: no

  roles:
    - role: buluma.sudo
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for sudo

# Do you want to wait for the host to be available?
sudo_wait_for_host: no

# The number of seconds you want to wait during connection test before failing.
sudo_timeout: 3
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-sudo/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-sudo/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|7, 8|
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
| alpine:edge | Failed to create temporary directory. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-sudo/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
