instance.disable-dpkg-trigger
=========

This role disables Ubuntu from automatically starting services when they're installed, allowing more control over configuration/customization before starting the service.

Requirements
------------

- Ubuntu.

Role Variables
--------------

None.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: instance.disable-dpkg-trigger
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

