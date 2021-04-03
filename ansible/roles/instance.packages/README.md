instance.packages
=========

This role installs apt, pip, and npm packages.

Future improvements include adding list variables for `_all`, `_group`, and `_host`, so that we can have flattened lists. (Example: some packages might get installed on just a single host, but include both group packages and ALL packages).

Requirements
------------

- Ubuntu.
- Python and python-pip, if pip packages are to be installed.
- NPM, if npm packages are to be installed.

Role Variables
--------------

- `apt_packages`
- `pip_packages`
- `pip3_packages`
- `npm_packages`

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: instance.packages
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

