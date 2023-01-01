topsail
=========

<img src="https://docs.ansible.com/ansible-tower/3.2.4/html_ja/installandreference/_static/images/logo_invert.png" width="10%" height="10%" alt="Ansible logo" align="right"/>
<a href="https://travis-ci.org/buluma/ansible-role-topsail"> <img src="https://travis-ci.org/buluma/ansible-role-topsail.svg?branch=master" alt="Build status"/></a> <img src="https://img.shields.io/ansible/role/d/"/> <img src="https://img.shields.io/ansible/quality/"/>

Install and configure tomcat on your system.

Example Playbook
----------------

This example is taken from `molecule/resources/playbook.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.topsail"
      ansible.builtin.include_role:
        name: "buluma.topsail"
      vars:
        check_sudo: false
        check_facts: false
```

The machine you are running this on, may need to be prepared, I use this playbook to ensure everything is in place to let the role work.
```yaml
No preparation required.
```


Also see a [full explanation and example](https://buluma.nl/how-to-use-these-roles.html) on how to use these roles.

Role Variables
--------------

These variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for topsail
# Verify token value with the sysctl command and set with -w if necessary
sysctl_set: yes

# if yes, performs a /sbin/sysctl -p if the sysctl_file is updated.
# If no, does not reload sysctl even if the sysctl_file is updated
sysctl_reload: yes

# If yes, sudo will be processed
check_sudo: false

# Do you want to wait for the host to be available?
sudo_wait_for_host: no

# The number of seconds you want to wait during connection test before failing.
sudo_timeout: 3

# If yes, facts will be processed
check_facts: false
```

Requirements
------------

- Access to a repository containing packages, likely on the internet.
- A recent version of Ansible. (Tests run on the current, previous and next release of Ansible.)

The following roles can be installed to ensure all requirements are met, using `ansible-galaxy install -r requirements.yml`:

```yaml
- none
```

Context
-------

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.nl/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/drawings/artifacts/topsail.png "Dependency")


Compatibility
-------------

This role has been tested on these [container images](https://hub.docker.com/):

|container|tag|allow_failures|
|---------|---|--------------|

This role has been tested on these Ansible versions:

- 
- 
- 




Testing
-------

[Unit tests](https://travis-ci.org/buluma/ansible-role-topsail) are done on every commit, pull request, release and periodically.

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-topsail/issues)

Testing is done using [Tox](https://tox.readthedocs.io/en/latest/) and [Molecule](https://github.com/ansible/molecule):

[Tox](https://tox.readthedocs.io/en/latest/) tests multiple ansible versions.
[Molecule](https://github.com/ansible/molecule) tests multiple distributions.

To test using the defaults (any installed ansible version, namespace: `buluma`, image: `fedora`, tag: `latest`):

```
molecule test

# Or select a specific image:
image=ubuntu molecule test
# Or select a specific image and a specific tag:
image="debian" tag="stable" tox
```

Or you can test multiple versions of Ansible, and select images:
Tox allows multiple versions of Ansible to be tested. To run the default (namespace: `buluma`, image: `fedora`, tag: `latest`) tests:

```
tox

# To run CentOS (namespace: `buluma`, tag: `latest`)
image="centos" tox
# Or customize more:
image="debian" tag="stable" tox
```

Modules
-------

This role uses the following modules:
```yaml
---
- ansible.builtin.assert
- ansible.builtin.debug
- ansible.builtin.import_tasks
- ansible.builtin.package_facts
- ansible.builtin.raw
- ansible.builtin.set_fact
- ansible.builtin.wait_for
```

License
-------

Apache-2.0


Author Information
------------------

[Michael Buluma](https://buluma.nl/)
