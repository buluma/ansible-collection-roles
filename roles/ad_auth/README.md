# [ad_auth](#ad_auth)

Bind a system to Active Directory.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-ad_auth/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ad_auth/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ad_auth/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ad_auth)|[![quality](https://img.shields.io/ansible/quality/58349)](https://galaxy.ansible.com/buluma/ad_auth)|[![downloads](https://img.shields.io/ansible/role/d/58349)](https://galaxy.ansible.com/buluma/ad_auth)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ad_auth.svg)](https://github.com/buluma/ansible-role-ad_auth/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.ad_auth
      ad_auth_registration_username: my_username
      ad_auth_registration_password: my_password
      ad_auth_ou: ou=Nerds,ou=Staff
      ad_auth_server: my_server.example.com
      ad_auth_domain: my_domain.local
      ad_auth_join: no
      ad_auth_simple_allow_users:
        - my_user_1
        - my_user_2
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
    - role: buluma.epel
    - role: buluma.python_pip
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ad_auth

# The username to register to AD, for example: "bind_user"
ad_auth_registration_username: "unset"

# The password to register to AD, for example: "MyPaSsWoRd"
ad_auth_registration_password: "unset"

# The OU to search in, for example: "ou=Nerds,ou=Staff"
ad_auth_ou: "unset"

# The server to bind to, for example: "ad.example.com"
ad_auth_server: "unset"

# The domain to use for SSSD configuration, for example: "example.com"
ad_auth_domain: "usnet.local"

# Should this role try to bind to the AD server?
# (This can be unset for automated testing)
ad_auth_join: yes

# To limit selected users to login, fill this list with users that are
# allowed to login:
# ad_auth_simple_allow_users:
#   - my_user_1
#   - my_user_2
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ad_auth/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ad_auth/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ad_auth/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Robert de Bock](https://buluma.github.io/)
