# [sudo-pair](#sudo-pair)

Install and configure sudo-pair on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-sudo-pair/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sudo-pair/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-sudo-pair/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sudo-pair)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/sudo-pair)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/sudo-pair)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-sudo-pair.svg)](https://github.com/buluma/ansible-role-sudo-pair/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.sudo-pair
      sudo_pair_gids_exempted:
        - 123
      sudo_pair_gids_enforced:
        - 321
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
    - role: buluma.core_dependencies
    - role: buluma.buildtools
    - role: buluma.cargo
    - role: buluma.git
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for sudo-pair

# The version to install.
sudo_pair_version: sudo_pair-v1.0.0

# The userids that are exempted
# sudo_pair_gids_exempted:
#   - 123

# The userids that are enforced
# sudo_pair_gids_enforced:
#   - 321
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-sudo-pair/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.cargo](https://galaxy.ansible.com/buluma/cargo)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cargo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cargo/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cargo/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cargo)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-git/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-sudo-pair/png/requirements.png "Dependencies")

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

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Alpine | cannot produce cdylib for `sudo_pair v0.11.1 (/tmp/sudo_pair-sudo_pair-v0.11.1/sudo_pair)` as the target `x86_64-unknown-linux-musl` does not support these crate types |

## [Included version(s)](#included-versions)

This role [refers to a version](https://github.com/buluma/ansible-role-sudo-pair/blob/master/defaults/main.yml) released by square on GitHub. Check the released version(s) here:
- [sudo_pair](https://github.com/square/sudo_pair/releases).

This version reference means a role may get outdated. Monthly tests occur to see if [bit-rot](https://en.wikipedia.org/wiki/Software_rot) occured. If you however find a problem, please create an issue, I'll get on it as soon as possible.

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-sudo-pair/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).