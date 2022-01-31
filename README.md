# Ansible Collection - buluma.roles

A collection of roles found on [buluma.nl](https://buluma.nl/).

## Using roles in this collection.

1. Install the collection:

```shell
ansible-galaxy collection install buluma.roles
```

You can also list a collection in `requirements.yml`:

```yaml
---
collections:
  - name: buluma.roles
```

2. Include roles in your playbooks:

```yaml
---
- name: make a great machine
  hosts: all
  tasks:
    - name: bootstrap
      import_role:
        name: buluma.roles.bootstrap
```
