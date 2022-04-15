# [update](#update)

Install updates on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-update/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-update/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-update/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-update)|[![quality](https://img.shields.io/ansible/quality/57816)](https://galaxy.ansible.com/buluma/update)|[![downloads](https://img.shields.io/ansible/role/d/57816)](https://galaxy.ansible.com/buluma/update)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-update.svg)](https://github.com/buluma/ansible-role-update/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.update
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for update

# For APT (Debian/Ubuntu) only: remove unused dependency packages for all module states except `build-dep'
update_autoremove: no

# For APT (Debian/Ubuntu) only: apt_upgrade type which can be: dist, full, yes, or safe
update_upgrade_command: dist

# For APT (Debian/Ubuntu) only: update the apt cache if it's older than the cache_valid_time. Set in seconds.
update_cache_valid_time: 1

# When updating systems, a reboot may be required. Here you can select to:
# "yes": Always reboot when packages have changed.
# "no": Never reboot when packages have changed.
update_reboot: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-update/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-update/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|34|
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
| Archlinux & Ansible 2.7 | New-style module did not handle its own exit |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-update/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
