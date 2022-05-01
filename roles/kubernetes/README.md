# [kubernetes](#kubernetes)

Kubernetes for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-kubernetes/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-kubernetes/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-kubernetes/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-kubernetes)|[![quality](https://img.shields.io/ansible/quality/54986)](https://galaxy.ansible.com/buluma/kubernetes)|[![downloads](https://img.shields.io/ansible/role/d/54986)](https://galaxy.ansible.com/buluma/kubernetes)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-kubernetes.svg)](https://github.com/buluma/ansible-role-kubernetes/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-kubernetes.svg)](https://github.com/buluma/ansible-role-kubernetes/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-kubernetes.svg)](https://github.com/buluma/ansible-role-kubernetes/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    # Allow swap in test environments (hard to control in some Docker envs).
    kubernetes_kubelet_extra_args: "--fail-swap-on=false --cgroup-driver=cgroupfs"
    docker_install_compose: false

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    - name: Ensure test dependencies are installed (RedHat).
      package: name=iproute state=present
      when: ansible_os_family == 'RedHat'

    - name: Ensure test dependencies are installed (Debian).
      package: name=iproute2 state=present
      when: ansible_os_family == 'Debian'

    - name: Gather facts.
      action: setup

  roles:
    - role: buluma.kubernetes

  post_tasks:
    - name: Get cluster info.
      command: kubectl cluster-info
      changed_when: false
      register: kubernetes_info

    - name: Print cluster info.
      debug: var=kubernetes_info.stdout

    - name: Get all running pods.
      command: kubectl get pods --all-namespaces
      changed_when: false
      register: kubernetes_pods

    - name: Print list of running pods.
      debug: var=kubernetes_pods.stdout
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
    - role: buluma.docker
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
kubernetes_packages:
  - name: kubelet
    state: present
  - name: kubectl
    state: present
  - name: kubeadm
    state: present
  - name: kubernetes-cni
    state: present

kubernetes_version: '1.20'
kubernetes_version_rhel_package: '1.20.4'

kubernetes_role: master

# This is deprecated. Please use kubernetes_config_kubelet_configuration instead.
kubernetes_kubelet_extra_args: ""

kubernetes_kubeadm_init_extra_opts: ""
kubernetes_join_command_extra_opts: ""
kubernetes_allow_pods_on_master: true
kubernetes_pod_network:
  # Flannel CNI.
  cni: 'flannel'
  cidr: '10.244.0.0/16'
  # Calico CNI.
  # cni: 'calico'
  # cidr: '192.168.0.0/16'

kubernetes_kubeadm_kubelet_config_file_path: '/etc/kubernetes/kubeadm-kubelet-config.yaml'
kubernetes_config_kubelet_configuration:
  cgroupDriver: "cgroupfs"

kubernetes_config_init_configuration:
  localAPIEndpoint:
    advertiseAddress: "{{ kubernetes_apiserver_advertise_address | default(ansible_default_ipv4.address, true) }}"
# if you use the next lines, remove the command line argument below
# nodeRegistration:
#    ignorePreflightErrors:
#      - all

kubernetes_config_cluster_configuration:
  networking:
    podSubnet: "{{ kubernetes_pod_network.cidr }}"
  kubernetesVersion: "{{ kubernetes_version_kubeadm }}"

kubernetes_config_kube_proxy_configuration: {}

kubernetes_apiserver_advertise_address: ''
kubernetes_version_kubeadm: 'stable-{{ kubernetes_version }}'
kubernetes_ignore_preflight_errors: 'all'

kubernetes_apt_release_channel: main
# Note that xenial repo is used for all Debian derivatives at this time.
kubernetes_apt_repository: "deb http://apt.kubernetes.io/ kubernetes-xenial {{ kubernetes_apt_release_channel }}"
kubernetes_apt_ignore_key_error: false

kubernetes_yum_arch: '$basearch'
kubernetes_yum_base_url: "https://packages.cloud.google.com/yum/repos/kubernetes-el7-{{ kubernetes_yum_arch }}"
kubernetes_yum_gpg_key:
  - https://packages.cloud.google.com/yum/doc/yum-key.gpg
  - https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

kubernetes_yum_gpg_check: true
kubernetes_yum_repo_gpg_check: true

# Flannel config files.
kubernetes_flannel_manifest_file_rbac: https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
kubernetes_flannel_manifest_file: https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Calico config files
kubernetes_calico_manifest_file: https://projectcalico.docs.tigera.io/manifests/calico.yaml
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-kubernetes/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.docker](https://galaxy.ansible.com/buluma/docker)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-docker/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-docker)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-kubernetes/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|bionic, focal|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-kubernetes/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-kubernetes/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
