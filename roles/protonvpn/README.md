# ansible-role-protonvpn

[![Build Status](https://travis-ci.org/tkimball83/ansible-role-protonvpn.svg?branch=master)](https://travis-ci.org/tkimball83/ansible-role-protonvpn)
[![Ansible Galaxy](https://img.shields.io/badge/ansible--galaxy-protonvpn-blue.svg?style=flat)](https://galaxy.ansible.com/tkimball83/protonvpn)
[![License](https://img.shields.io/badge/license-GPLv3-brightgreen.svg?style=flat)](COPYING)

macOS - Secure internet anywhere

## Requirements

This role requires homebrew to be installed

## Role Variables

Available variables are listed below, along with default values:

    protonvpn_defaults: []
    protonvpn_domain: "ch.{{ protonvpn_package|lower }}.mac"
    protonvpn_package: ProtonVPN

## Dependencies

None

## Example Playbook

    - hosts: localhost
      connection: local
      roles:
        - role: tkimball83.protonvpn
          protonvpn_defaults:
            - name: AutoConnect
              type: bool
              value: true
            - name: ConnectOnDemand
              type: bool
              value: true
            - name: LaunchedBefore
              type: bool
              value: true
            - name: NeagentAppeared
              type: bool
              value: true
            - name: "{{ 'NetShield' + ansible_user_id }}"
              type: int
              value: 2
            - name: RememberLogin
              type: bool
              value: true
            - name: StartMinimized
              type: bool
              value: false
            - name: StartOnBoot
              type: bool
              value: true
            - name: SystemNotifications
              type: bool
              value: true

## License

Copyright (C) 2021 Taylor Kimball <tkimball@linuxhq.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
