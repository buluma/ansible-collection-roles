# Ansible Role: SMTP

![Build Status](https://github.com/vladgh/ansible-role-smtp/workflows/CI/badge.svg)

Vlad's SMTP Ansible Role

## Requirements

*_N/A_*

## Role Variables

Available variables are listed below, along with default values (see defaults/main.yml):

- `smtp_server_address`: The address of the SMTP server
- `smtp_server_port`: The port of the SMTP server
- `smtp_user`: The SMTP user
- `smtp_password`: The SMTP password
- `smtp_from`: The SMTP From address

## Dependencies

*_N/A_*

## Example Playbook

```yaml
- hosts: all
  become: yes
  vars:
    - smtp_server_address: smtp.sendgrid.net
    - smtp_server_port: 587
    - smtp_user: apikey
    - smtp_password: xxxxx
    - smtp_from: user@example.com
  roles:
    - vladgh.smtp
```

## Contribute

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code_of_conduct.md)

Contributions are always welcome! Please read the [contribution guidelines](.github/CONTRIBUTING.md) and the [code of conduct](.github/CODE_OF_CONDUCT.md).

## License

Licensed under the Apache License, Version 2.0.
See [LICENSE](LICENSE) file.
