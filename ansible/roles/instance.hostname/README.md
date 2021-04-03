instance.hostname
=========

This role sets the hostname to a specified variable.

Requirements
------------

- None

Role Variables
--------------

- `hostname`. If `hostname` is not defined, it will default to the Ansbiel `inventory_hostname`.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: instance.hostname
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

