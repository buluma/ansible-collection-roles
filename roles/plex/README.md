# [plex](#plex)

Role to install Plex Media Server, Tautulli (former PlexPy) and Plexupdate in one go!


|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-plex/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-plex/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-plex/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-plex)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/plex)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/plex)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-plex.svg)](https://github.com/buluma/ansible-role-plex/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-plex.svg)](https://github.com/buluma/ansible-role-plex/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-plex.svg)](https://github.com/buluma/ansible-role-plex/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  gather_facts: false
  tasks:
    - name: "Include buluma.plex"
      ansible.builtin.include_role:
        name: "buluma.plex"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for plex
# If Tautulli will get installed
tautulli_install: false
# Version of Tautulli to install, gets passed to git module
tautulli_version: master
# User to run tautulli as
tautulli_user: tautulli
# Group to run tautulli as
tautulli_group: tautulli
# Tautulli install location
tautulli_install_location: /opt/Tautulli/
# Tautulli configuration location (recommended is to put it somewhere in /etc)
tautulli_config_location: /etc/tautulli-config.ini
# Tautulli data location (recommended is to NOT put it in your Tautulli exec dir)
tautulli_data_location: "{{ tautulli_install_location }}/data"

# If plexupdate will get installed
plexupdate_install: false
# Version of Tautulli to install, gets passed to git module
plexupdate_version: master
# Plexupdate install location
plexupdate_install_location: /opt/plexupdate/
# Plexupdate config location
plexupdate_config_location: /etc/plexupdate.conf
# Plexupdate cronwrapper location, change cron.daily to interval (cron.hourly, cron.daily, cron.weekly, cron.monthly)
plexupdate_cronwrapper: /etc/cron.daily/plexupdate

# Cron options for plexupdate
# If Plexupdate will automatically install newly downloaded version
plexupdate_autoinstall: true
# If Plexupdate will delete the downloaded package after installation to conserve disk space
plexupdate_autoupdate: true
# If Plexupdate will download the public release (set to no to download PlexPass releases)
plexupdate_public: true
# If Plexupdate will notify by mail after cron error
plexupdate_notify: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-plex/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-plex/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|
|fedora|36|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.6, tests have been done to:

- The previous version.
- The current version.
- The development version.


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-plex/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-plex/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
