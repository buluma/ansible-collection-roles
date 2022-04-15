# [puppet](#puppet)

Install Puppet on your system (Linux).

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-puppet/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-puppet/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-puppet/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-puppet)|[![quality](https://img.shields.io/ansible/quality/55008)](https://galaxy.ansible.com/buluma/puppet)|[![downloads](https://img.shields.io/ansible/role/d/55008)](https://galaxy.ansible.com/buluma/puppet)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-puppet.svg)](https://github.com/buluma/ansible-role-puppet/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-puppet.svg)](https://github.com/buluma/ansible-role-puppet/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-puppet.svg)](https://github.com/buluma/ansible-role-puppet/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: buluma.java
      when: ansible_os_family == 'Debian'
    - role: buluma.puppet
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
puppet_package: puppetserver

puppet_service: puppetserver
puppet_service_state: started
puppet_service_enabled: false
puppet_service_manage: false

puppet_bin_path: /opt/puppetlabs/bin

# Used only for Debian/Ubuntu.
puppet_apt_deb: "https://apt.puppetlabs.com/puppet6-release-{{ ansible_distribution_release }}.deb"

# Used only for RedHat/CentOS.
puppet_yum_rpm: "https://yum.puppet.com/puppet6-release-el-{{ ansible_distribution_major_version }}.noarch.rpm"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-puppet/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-puppet/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|debian|all|
|el|8|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-puppet/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
