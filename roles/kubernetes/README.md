# [Ansible role kubernetes](#ansible-role-kubernetes)

Kubernetes for Linux.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-kubernetes/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-kubernetes/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-kubernetes.svg)](https://github.com/buluma/ansible-role-kubernetes/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-kubernetes.svg)](https://github.com/buluma/ansible-role-kubernetes/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-kubernetes.svg)](https://github.com/buluma/ansible-role-kubernetes/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/kubernetes)](https://galaxy.ansible.com/ui/standalone/roles/buluma/kubernetes/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-kubernetes/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  post_tasks:
    - ansible.builtin.command: kubectl cluster-info
      changed_when: false
      name: Get cluster info.
      register: kubernetes_info
    - ansible.builtin.debug:
        var: kubernetes_info.stdout
      name: Print cluster info.
    - ansible.builtin.command: kubectl get pods --all-namespaces
      changed_when: false
      name: Get all running pods.
      register: kubernetes_pods
    - ansible.builtin.debug:
        var: kubernetes_pods.stdout
      name: Print list of running pods.
  pre_tasks:
    - ansible.builtin.apt:
        cache_valid_time: "600"
        update_cache: "true"
      name: Update apt cache.
      when: ansible_facts['os_family'] == 'Debian'
    - ansible.builtin.package:
        name: iproute
        state: present
      name: Ensure test dependencies are installed (RedHat).
      when: ansible_facts['os_family'] == 'RedHat'
    - ansible.builtin.package:
        name: iproute2
        state: present
      name: Ensure test dependencies are installed (Debian).
      when: ansible_facts['os_family'] == 'Debian'
    - ansible.builtin.setup:
      name: Gather facts.
  roles:
    - role: buluma.kubernetes
  vars:
    docker_install_compose: false
    kubernetes_containerd_snapshotter: native
    kubernetes_kubelet_extra_args: --fail-swap-on=false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-kubernetes/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.core_dependencies
    - role: buluma.setuptools
    - role: buluma.docker
      # ansible-role-docker has no repository-setup logic and never
      # carried a working package on RHEL-family (see its own
      # meta/preferences.yml); docker_ce handles that case instead.
      when: ansible_facts['os_family'] != 'RedHat'
    - role: buluma.docker_ce
      when: ansible_facts['os_family'] == 'RedHat'
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-kubernetes/blob/master/defaults/main.yml):

```yaml
---
kubernetes_allow_pods_on_master: true
kubernetes_apiserver_advertise_address: ""
kubernetes_apt_ignore_key_error: false
kubernetes_apt_keyring_path: /etc/apt/keyrings/kubernetes-apt-keyring.gpg
kubernetes_apt_key_url: "https://pkgs.k8s.io/core:/stable:/v{{ kubernetes_version }}/deb/Release.key"
kubernetes_apt_repository: "deb [signed-by={{ kubernetes_apt_keyring_path }}] https://pkgs.k8s.io/core:/stable:/v{{ kubernetes_version }}/deb/ /"
kubernetes_calico_manifest_file: "https://projectcalico.docs.tigera.io/manifests/calico.yaml"
kubernetes_config_cluster_configuration:
  kubernetesVersion: "{{ kubernetes_version_kubeadm }}"
  networking:
    podSubnet: "{{ kubernetes_pod_network.cidr }}"
kubernetes_config_init_configuration:
  localAPIEndpoint:
    advertiseAddress: "{{ kubernetes_apiserver_advertise_address | default(ansible_facts['default_ipv4'].address, true) }}"
kubernetes_config_kube_proxy_configuration: {}
kubernetes_config_kubelet_configuration:
  cgroupDriver: systemd
kubernetes_flannel_manifest_file: "https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml"
kubernetes_ignore_preflight_errors: all
kubernetes_join_command_extra_opts: ""
kubernetes_kubeadm_init_extra_opts: ""
kubernetes_kubeadm_kubelet_config_file_path: /etc/kubernetes/kubeadm-kubelet-config.yaml
kubernetes_kubelet_extra_args: ""
kubernetes_packages:
  - name: kubelet
    state: present
  - name: kubectl
    state: present
  - name: kubeadm
    state: present
  - name: kubernetes-cni
    state: present
kubernetes_pod_network:
  cidr: 10.244.0.0/16
  cni: flannel
kubernetes_role: master
kubernetes_version: "1.36"
kubernetes_version_kubeadm: stable-{{ kubernetes_version }}
kubernetes_yum_base_url: "https://pkgs.k8s.io/core:/stable:/v{{ kubernetes_version }}/rpm/"
kubernetes_yum_gpg_check: true
kubernetes_yum_gpg_key:
  - "https://pkgs.k8s.io/core:/stable:/v{{ kubernetes_version }}/rpm/repodata/repomd.xml.key"
kubernetes_yum_repo_gpg_check: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-kubernetes/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.docker](https://galaxy.ansible.com/buluma/docker)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker/actions)|
|[buluma.docker_ce](https://galaxy.ansible.com/buluma/docker_ce)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker_ce/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker_ce/actions)|
|[buluma.setuptools](https://galaxy.ansible.com/buluma/setuptools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-setuptools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-setuptools/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-kubernetes/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|13, 12|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-kubernetes/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-kubernetes/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
