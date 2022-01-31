# [cntlm](#cntlm)

Install and configure cntlm on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-cntlm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cntlm/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-cntlm/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cntlm)|[![quality](https://img.shields.io/ansible/quality/25457)](https://galaxy.ansible.com/buluma/cntlm)|[![downloads](https://img.shields.io/ansible/role/d/25457)](https://galaxy.ansible.com/buluma/cntlm)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-cntlm.svg)](https://github.com/buluma/ansible-role-cntlm/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.cntlm
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
    - role: buluma.buildtools
    - role: buluma.epel
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for cntlm

# The version of CNTLM to install.
cntlm_version: "0.92.3"

# What release to install.
cntlm_release: 1

# Where to download CNTLM from.
cntlm_download_mirror: netcologne.dl.sourceforge.net

# CNTLM authenticate to the proxy, set a username, password and domain.
cntlm_username: changeme
cntlm_password: changeme
cntlm_domain: example.com
cntlm_proxy: "changeme.example.com:3128"

# To what port should CNTLM listen?
cntlm_listen: 3128

# When you've got a password hash, you may fill it in here.
# cntlm_passntlmv2: 1234567890abcdef

# What hosts to omit in the proxy.
cntlm_noproxy: localhost

# Where to install temporary files
cntlm_tmp: /root

# Which IPs or CIDR subnets CNTLM is accessible from.  Items other than 127.0.0.1 are only effective if gateway_enabled
# is yes
cntlm_allows:
  - "127.0.0.1"

# By default ("0/0"), CNTLM is inaccessible from all other IP addresses.
cntlm_denies:
  - "0/0"

# If yes, access to CNTLM is possible from outside of the local host, subject to cntlm_allows and cntlm_denies:
gateway_enabled: "no"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-cntlm/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-cntlm/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| EL | No package matching 'bison' found available, installed or updated |
| Alpine | Cannot make the task 'start and enable cntlm' idempotent. |

## [Included version(s)](#included-versions)

This role [refers to a version](https://github.com/buluma/ansible-role-cntlm/blob/master/defaults/main.yml) released by Mavey on SOURCEFORGE. Check the released version(s) here:
- [cntlm](https://sourceforge.net/projects/cntlm/files/).

This version reference means a role may get outdated. Monthly tests occur to see if [bit-rot](https://en.wikipedia.org/wiki/Software_rot) occured. If you however find a problem, please create an issue, I'll get on it as soon as possible.

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-cntlm/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
