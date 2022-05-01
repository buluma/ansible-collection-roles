# [eclipse](#eclipse)

Install eclipse and plugins on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-eclipse/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-eclipse/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-eclipse/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-eclipse)|[![quality](https://img.shields.io/ansible/quality/58801)](https://galaxy.ansible.com/buluma/eclipse)|[![downloads](https://img.shields.io/ansible/role/d/58801)](https://galaxy.ansible.com/buluma/eclipse)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-eclipse.svg)](https://github.com/buluma/ansible-role-eclipse/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-eclipse.svg)](https://github.com/buluma/ansible-role-eclipse/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-eclipse.svg)](https://github.com/buluma/ansible-role-eclipse/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.eclipse
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
    - role: buluma.core_dependencies
    - role: buluma.java
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for eclipse

# The release to install.
# See https://www.eclipse.org/downloads/packages/release
eclipse_release: 2022-03

# The release version to install, either: R, RC1, M3, M2 or M1.
eclipse_release_version: R

# The type of installation, either: jee, committers, cpp, dsl, java, javascript, jee, modeling, parallel, php, rcp, rust, scout or testing.
eclipse_release_type: java

eclipse_install_path: /opt

eclipse_plugins:
  # This plugin causes an issue:
  # org.eclipse.m2e.logback.configuration:
  # The org.eclipse.m2e.logback.configuration bundle was activated before
  # the state location was initialized.  Will retry after the state location
  # is initialized.
  # - name: org.tigris.subversion.subclipse.feature.group
  #   repository: "http://subclipse.tigris.org/update_1.10.x"
  # Causes issues on CI
  - name: org.sonatype.m2e.egit.feature.feature.group
    repository: "https://repo1.maven.org/maven2/.m2e/connectors/m2eclipse-egit/0.15.1/N/LATEST"

eclipse_plugins_state: no
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-eclipse/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-eclipse/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-eclipse/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-eclipse/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
