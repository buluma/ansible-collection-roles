# [firefox](#firefox)

Firefox Installation.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-firefox/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-firefox/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-firefox/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-firefox)|[![quality](https://img.shields.io/ansible/quality/59006)](https://galaxy.ansible.com/buluma/firefox)|[![downloads](https://img.shields.io/ansible/role/d/59006)](https://galaxy.ansible.com/buluma/firefox)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-firefox.svg)](https://github.com/buluma/ansible-role-firefox/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-firefox.svg)](https://github.com/buluma/ansible-role-firefox/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-firefox.svg)](https://github.com/buluma/ansible-role-firefox/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role: buluma.firefox
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.ca_certificates
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
firefox_checksum: sha512:a122bacbe2cc48301f696696e8854d190e0ce9ce72b39e9df90846214c536730a7190a858295f56e836b263bdc2e4e3041cb3bfad8d7cf483c50478c634c14f5
firefox_desktop_icon: false
firefox_home: /opt/firefox-{{ firefox_version }}
firefox_image_path: "firefox/browser/chrome/icons/default/default128.png"
firefox_logo: "{{ firefox_home }}/{{ firefox_image_path }}"
firefox_version: "99.0.1"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-firefox/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-firefox/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7|
|ubuntu|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-firefox/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-firefox/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
