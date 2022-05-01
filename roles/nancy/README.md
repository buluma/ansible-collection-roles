# [nancy](#nancy)

Installs nancy for go dependency vulnerability scanning

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-nancy/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nancy/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nancy/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nancy)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/nancy)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/nancy)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nancy.svg)](https://github.com/buluma/ansible-role-nancy/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nancy.svg)](https://github.com/buluma/ansible-role-nancy/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nancy.svg)](https://github.com/buluma/ansible-role-nancy/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.nancy
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
    - role: buluma.ca_certificates
    - role: andrewrothstein.unarchive-deps
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for nancy
nancy_ver: v1.0.33
nancy_os: linux
nancy_arch: amd64
nancy_mirror: https://github.com/sonatype-nexus-community/nancy/releases/download

nancy_parent_install_dir: /usr/local
nancy_privilege_escalate: True

nancy_checksums:
  v1.0.17:
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.17/nancy-v1.0.17-darwin-amd64.tar.gz
    darwin-amd64: sha256:87b109d8172fc5cac83ec92fae449b4cd9bc63a06ccd3a738b1853dc5d269d91
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.17/nancy-v1.0.17-linux-amd64.tar.gz
    linux-amd64: sha256:91ad2c7fa3d6d775c59b5c7e7f59d16c6de0fda95ffdc4c539b2ce201e0ce433
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.17/nancy-v1.0.17-windows-386.zip
    windows-386: sha256:64bbbdd6dc2ba8f77127bf932c552467cadbc6c3da7d2a0f747c9411a7d49c9a
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.17/nancy-v1.0.17-windows-amd64.zip
    windows-amd64: sha256:84c59b5ed434f3ff4298e0b68bb716177df896ce78082a5b9cad090b6a6ef4b3
  v1.0.19:
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.19/nancy-v1.0.19-darwin-amd64.tar.gz
    darwin-amd64: sha256:b0e6d62ff309f207b05e500d449b527b8b97c670426b592b8ed9f853a9d9fde4
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.19/nancy-v1.0.19-linux-amd64.tar.gz
    linux-amd64: sha256:cedb4c0a40da95e3d98a7338ce74712892a7122f51bab0ff740ff64bac375997
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.19/nancy-v1.0.19-windows-386.zip
    windows-386: sha256:c31ed420b4048f9786af473e497fe92775b84bbd352d4e4187bb6467fed886c3
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.19/nancy-v1.0.19-windows-amd64.zip
    windows-amd64: sha256:61742e0223327f9627ddcf8faa54744b7112123654185da4eb5db76a5c8230e1
  v1.0.20:
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.20/nancy-v1.0.20-darwin-amd64.tar.gz
    darwin-amd64: sha256:6fa0d8235852e653ec86cfb87c97ec1af39a6641605c9f5fca97d7e12fa2512a
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.20/nancy-v1.0.20-linux-amd64.tar.gz
    linux-amd64: sha256:31b0037369e4a8108c5f03249058d2918117b3647cd6b7f8d1bc6bb5e5603bfa
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.20/nancy-v1.0.20-windows-386.zip
    windows-386: sha256:49074fc69951a4ac2ec37cb7ef5b8cb81f45c09e297a04e79a14687939dc987e
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.20/nancy-v1.0.20-windows-amd64.zip
    windows-amd64: sha256:631245ab03816515f7026096cc75f03bb919e427db2cd02aa2c461ccc0310c43
  v1.0.21:
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.21/nancy-v1.0.21-darwin-amd64.tar.gz
    darwin-amd64: sha256:6dfb6a4ecea63b1799032fb26822487824eff5c188006263196ffbdbbe224105
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.21/nancy-v1.0.21-linux-amd64.tar.gz
    linux-amd64: sha256:77dcf21ce6276cdb08ba5247b7c272ff495202fd4e719632bc7c5df5ade00aef
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.21/nancy-v1.0.21-windows-386.zip
    windows-386: sha256:c2b3bb4c75e88d092e25d2ec8d9ddee3f66e24e711e1b82e7c9ae067cc014bc4
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.21/nancy-v1.0.21-windows-amd64.zip
    windows-amd64: sha256:90cb3458eba70dead10e89f615801c76e449e034e748625ee341c02fe8232da9
  v1.0.22:
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.22/nancy-v1.0.22-darwin-amd64.tar.gz
    darwin-amd64: sha256:fc09f4c5d0b62034121473fa7ab265edbe6d538dc77d9a1c023ff59fd5ec588c
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.22/nancy-v1.0.22-linux-amd64.tar.gz
    linux-amd64: sha256:5b3bac98b07e2719174575d8d82b27b8eead6eaec0efb4dc9721ebcfe3207682
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.22/nancy-v1.0.22-windows-386.zip
    windows-386: sha256:d28595ed492789cbdaf40a5abc2ce76af8975c4a0ec09d4b33440b8ff7333098
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.22/nancy-v1.0.22-windows-amd64.zip
    windows-amd64: sha256:96ffabb69566539957ed50e8c005a961052b65029e0fc8f40b8cc1769dca4dfd
  v1.0.30:
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-darwin-amd64.tar.gz
    darwin-amd64: sha256:2943fa83ed990a82cea84b38365ed0cde566da5113f12d83a930a9eefb487e89
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-darwin-arm64.tar.gz
    darwin-arm64: sha256:33a0a001113e866560a4caa8371102a20e34b3b9e0a2486ebba97cb7f94090b6
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-linux-386.tar.gz
    linux-386: sha256:98d76cf8d7d222bf7b489781bfff3b6750ee06b1964f3d77a36bd7c214aa5453
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-linux-amd64.tar.gz
    linux-amd64: sha256:30aa2af3ddc517d736feb6d0cc09c790459b0729375fe62f31cce75f57fbf38c
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-linux-arm64.tar.gz
    linux-arm64: sha256:4696017c77bde9b81f0a11c3b9bb9a7c10b8c59a30a9be79f3965522cd2d84eb
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-windows-386.zip
    windows-386: sha256:7edcbab9b2f1f20ce29c808e5da27cf93122273c3d7e0f0deded7cc6f144fa43
    # https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-windows-amd64.zip
    windows-amd64: sha256:8102a4d99d682bbeef3b63505d2ad0930412ef68148e7eb0f3ae26630833410f
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nancy/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|
|[andrewrothstein.unarchive-deps](https://galaxy.ansible.com/buluma/andrewrothstein.unarchive-deps)|[![Build Status GitHub](https://github.com/buluma/andrewrothstein.unarchive-deps/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/andrewrothstein.unarchive-deps/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/andrewrothstein.unarchive-deps/badges/master/pipeline.svg)](https://gitlab.com/buluma/andrewrothstein.unarchive-deps)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- andrewrothstein.unarchive-deps
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nancy/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|archlinux|all|
|debian|all|
|el|8|
|fedora|all|
|ubuntu|bionic, focal|

The minimum version of Ansible required is 2.0, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nancy/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-nancy/blob/master/CHANGELOG.md)

## [License](#license)

['MIT']

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
