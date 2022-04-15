# [locale](#locale)

Configure locale on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-locale/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-locale/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-locale/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-locale)|[![quality](https://img.shields.io/ansible/quality/57942)](https://galaxy.ansible.com/buluma/locale)|[![downloads](https://img.shields.io/ansible/role/d/57942)](https://galaxy.ansible.com/buluma/locale)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-locale.svg)](https://github.com/buluma/ansible-role-locale/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.locale
      locale_lang: de_AT.UTF-8
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for locale

# Set one locale from the output of the shell command `locale -a`.
# A few common locales: en_US.UTF-8, nl_NL.utf8, C.utf8, POSIX

locale_lang: en_US.UTF-8
locale_language: "{{ locale_lang }}"
locale_lc_address: "{{ locale_lang }}"
locale_lc_all: "{{ locale_lang }}"
locale_lc_collate: "{{ locale_lang }}"
locale_lc_ctype: "{{ locale_lang }}"
locale_lc_identification: "{{ locale_lang }}"
locale_lc_measurement: "{{ locale_lang }}"
locale_lc_messages: "{{ locale_lang }}"
locale_lc_monetary: "{{ locale_lang }}"
locale_lc_name: "{{ locale_lang }}"
locale_lc_numeric: "{{ locale_lang }}"
locale_lc_paper: "{{ locale_lang }}"
locale_lc_response: "{{ locale_lang }}"
locale_lc_telephone: "{{ locale_lang }}"
locale_lc_time: "{{ locale_lang }}"

locale_timezone: Etc/UTC
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-locale/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-locale/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-locale/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
