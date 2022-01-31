# [minikube](#minikube)

Install and configure minikube on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-minikube/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-minikube/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-minikube/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-minikube)|[![quality](https://img.shields.io/ansible/quality/42933)](https://galaxy.ansible.com/buluma/minikube)|[![downloads](https://img.shields.io/ansible/role/d/42933)](https://galaxy.ansible.com/buluma/minikube)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-minikube.svg)](https://github.com/buluma/ansible-role-minikube/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.minikube
      minikube_user: minikube
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
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.docker
    - role: buluma.kubectl
    - role: buluma.sysctl
      sysctl_items:
        - name: net.bridge.bridge-nf-call-iptables
          value: 1
        - name: fs.protected_regular
          value: 0
    - role: buluma.users
      users_user_list:
        - name: minikube
          groups: docker
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for minikube

# `minikube start` should start as a non-root-user. This should be an exising
# user on the Linux system. (Hint: buluma.users)
minikube_user: minikube

minikube_command: "/usr/bin/minikube start --driver=none"
# minikube_command: "/usr/bin/minikube start --vm-driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost --extra-config=kubelet.cgroup-driver=systemd"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-minikube/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.docker](https://galaxy.ansible.com/buluma/docker)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-docker/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-docker)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.kubectl](https://galaxy.ansible.com/buluma/kubectl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-kubectl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-kubectl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-kubectl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-kubectl)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|
|[buluma.sysctl](https://galaxy.ansible.com/buluma/sysctl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-sysctl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sysctl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-sysctl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sysctl)|
|[buluma.users](https://galaxy.ansible.com/buluma/users)|[![Build Status GitHub](https://github.com/buluma/ansible-role-users/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-users/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-users/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-users)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-minikube/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.


## [Included version(s)](#included-versions)

This role [refers to a version](https://github.com/buluma/ansible-role-minikube/blob/master/defaults/main.yml) released by Google. Check the released version(s) here:
- [A Debian package of Minikube](https://storage.googleapis.com/minikube/releases).
- [A Red Hat package of Minikube](https://storage.googleapis.com/minikube/releases).

This version reference means a role may get outdated. Monthly tests occur to see if [bit-rot](https://en.wikipedia.org/wiki/Software_rot) occured. If you however find a problem, please create an issue, I'll get on it as soon as possible.

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-minikube/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).