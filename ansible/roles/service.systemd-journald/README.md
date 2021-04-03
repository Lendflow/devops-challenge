service.systemd-journald
=========

This role configures the `systemd-journald` service.

Requirements
------------

- Ubuntu.
- SystemD.

Role Variables
--------------

- `restart_systemd_journald` - To force a restart of the `systemd-journald` service.

Dependencies
------------

Requires the following roles:
- service.docker

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: service.systemd-journald
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

