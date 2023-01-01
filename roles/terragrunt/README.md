# ansible-role-terragrunt

[![molecule](https://github.com/diodonfrost/ansible-role-terragrunt/workflows/molecule/badge.svg)](https://github.com/diodonfrost/ansible-role-terragrunt/actions)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-diodonfrost.terragrunt-660198.svg)](https://galaxy.ansible.com/diodonfrost/terragrunt)

This role provide a compliance for install terragrunt on your target host.

## Requirements

This role was developed using Ansible 2.8 Backwards compatibility is not guaranteed.
Use `ansible-galaxy install diodonfrost.terragrunt` to install the role on your system.

## Role Variables

This role has multiple variables. The defaults for all these variables are the following:

```yaml
---
# defaults file for ansible-role-terragrunt

# Define terragrunt version to install
# Possible values: https://api.github.com/repos/gruntwork-io/terragrunt/releases
# Default: latest
terragrunt_version: latest

# Define where to install Terragrunt binary
# Default: use local system path defined in Ansible vars/*.yml
terragrunt_path: "{{ terragrunt_default_path }}"
```

## Dependencies

None

## Example Playbook

This is a sample playbook file for deploying the Ansible Galaxy terragrunt role in a localhost and installing latest terragrunt version.

```yaml
---
- hosts: localhost
  become: true
  roles:
    - role: diodonfrost.terragrunt
```

This role can also install a specific version of terragrunt.

```yaml
---
- hosts: localhost
  become: true
  roles:
    - role: ansible-role-terragrunt
      vars:
        terragrunt_version: v0.18.0
```

## Local Testing

This project uses [Molecule](http://molecule.readthedocs.io/) to aid in the
development and testing.

To develop or test you'll need to have installed the following:

* Linux (e.g. [Ubuntu](http://www.ubuntu.com/))
* [Docker](https://www.docker.com/)
* [Python](https://www.python.org/) (including python-pip)
* [Ansible](https://www.ansible.com/)
* [Molecule](http://molecule.readthedocs.io/)
* [Virtualbox](https://www.virtualbox.org/) (windows test only)
* [Vagrant](https://www.vagrantup.com/downloads.html) (windows test only)

### Testing with Docker

```shell
# Install requirements
pip install -r requirements-dev.txt

# Test ansible role with centos 8
molecule test

# Test ansible role with ubuntu 18.04
image=ansible-ubuntu:18.04 molecule test

# Create centos 7 instance
image=ansible-centos:7 molecule create

# Apply role on centos 7 instance
image=ansible-centos:7 molecule converge

# Launch tests on centos 7 instance
image=ansible-centos:7 molecule verify
```

### Testing with Vagrant and Virtualbox

```shell
# Test ansible role with Windows
molecule test -s windows
```

## License

Apache 2

## Author Information

This role was created in 2019 by diodonfrost.
