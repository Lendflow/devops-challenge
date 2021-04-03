instance.print-hostkey
=========

This role prints the SSH public host key to the console (which allows it to be scraped via the AWS system log).

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
    - role: instance.print-hostkey
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

