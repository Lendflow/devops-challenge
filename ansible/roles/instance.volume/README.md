instance.volume
=========

This role formats and mounts a data volume. Note that it WILL mount based on the discovered `uuid`.

Requirements
------------

- Ubuntu.
- SystemD.

Role Variables
--------------

Look at the  [defaults/main.yml](defaults/main.yml) file some examples.

- `filesystem_dev` - the device that will be mounted, such as `/dev/xvde`.
- `filesystem_fstype` - the fileystem. Defaults to `ext4`.
- `filesystem_options` - the filesystem options. Defaults to `defaults,auto,noatime,nodiratime,relatime,nofail`.
- `volume_mount` - the mountpoint for the volume, such as `/data`.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: instance.volume
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

