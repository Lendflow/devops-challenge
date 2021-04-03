instance.python-install
=========

This role installs the core requirements for Ansible, including Python and Aptitude. Since this is meant to be run before facts are gathered, it will also gather facts after these packages are installed.

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
  gather_facts: no
- roles:
    - role: instance.python-install
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

