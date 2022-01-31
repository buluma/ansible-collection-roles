# [nfsserver](#nfsserver)

Setup exports on an nfs server

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-nfsserver/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nfsserver/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nfsserver/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nfsserver)|[![quality](https://img.shields.io/ansible/quality/51495)](https://galaxy.ansible.com/buluma/nfsserver)|[![downloads](https://img.shields.io/ansible/role/d/51495)](https://galaxy.ansible.com/buluma/nfsserver)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nfsserver.svg)](https://github.com/buluma/ansible-role-nfsserver/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.nfsserver
      nfsserver_exports:
        - share: /mnt/export
          hosts:
            - name: "10.0.0.0/24"
              options:
                - ro
                - no_subtree_check
                - nohide
            - name: "172.16.0.0/24"
              options:
                - rw
                - sync
                - no_wdelay
        - share: /mnt/export2
          hosts:
            - name: "10.2.3.0/24"
              options:
                - ro
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
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for nfsserver

# You can define a list of exports:
# nfsserver_exports:
#   - share: /mnt/export
#     hosts:
#       - name: "10.0.0.0/24"
#         options:
#           - ro
#           - no_subtree_check
#           - nohide
nfsserver_exports: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nfsserver/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nfsserver/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|8|
|debian|bullseye|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nfsserver/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).