# [selinux](#selinux)

Install and configure selinux and its required libraries on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-selinux/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-selinux)|[![quality](https://img.shields.io/ansible/quality/57923)](https://galaxy.ansible.com/buluma/selinux)|[![downloads](https://img.shields.io/ansible/role/d/57923)](https://galaxy.ansible.com/buluma/selinux)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-selinux.svg)](https://github.com/buluma/ansible-role-selinux/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.selinux
      selinux_reboot: no
      selinux_booleans:
        - name: http_can_network_connect
        - name: abrt_anon_write
          state: no
          persistent: no
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for selinux

# The state, either disabled, permissive or enforcing.
selinux_state: enforcing

# The policy, default: see vars/main.yml.
# The policy differs per distribution, mostly because Debian and Ubuntu use 'default' and other distributions use 'targeted'.
selinux_policy: "{{ _selinux_policy[ansible_os_family] | default(_selinux_policy['default'] ) }}"

# Should the machine be rebooted after changes?
selinux_reboot: yes

# You can enable (or disable) booleans by specifying them in this list.
# selinux_booleans:
#   - name: http_can_network_connect
#   - name: abrt_anon_write
#     state: no
#     persistent: no
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-selinux/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-selinux/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
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
| Archlinux & Ansible 2.7 | New-style module did not handle its own exit |
| amazonlinux | Dependency (reboot) does not work on amazonlinux. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-selinux/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
