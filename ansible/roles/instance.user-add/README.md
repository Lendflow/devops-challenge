instance.user-add
=========

This role adds users to the system.

Requirements
------------

None

Role Variables
--------------

List of variables can be found in [./defaults/main.yml](defaults/main.yml).

Probably the most simple setup would be a variable in either a group or host inventory:

```
user_list_group:
  - name: bsmith
    ssh_public_key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDOQWYAij7sq4v+jurNldqf1w0gxsWU3qlxqh8L1p/9xDznx+pEHT478/f4KFpuMm80rMk3Xc9lgrZETbaUa7PYsTymcnjiWhTdFHyeGcTFVnZSACWW6wlvpWeYxDrCrMzURrDGn+wdAPSkHo3BR0fLVNXbYGCpnNGgwjeZa04kiTzqhP4qTmHnXnaBvbnPDl+NKQQQxPFyCbVyTcJ9XMXO2KIwBDDNva9Vrm+2b3PVFAOW0TddGu4EwuVsbiWs+Mblphxc4GyhoeplXXWMfI8fRN6om9WCqDlxoMmacNm7y43Txvp5/Gpx7bkuAHvKs88gH9anbs8ogzD9LebI5sr bsmith@aol.com"
    sudo: yes
  - name: jsmith
    ssh_public_key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDOQWYAij7sq4v+jurNldqf1w0gxsWU3qlxqh8L1p/9xDznx+pEHT478/f4KFpuMm80rMk3Xc9lgrZETbaUa7PYsTymcnjiWhTdFHyeGcTFVnZSACWW6wlvpWeYxDrCrMzURrDGn+wdAPSkHo3BR0fLVNXbYGCpnNGgwjeZa04kiTzqhP4qTmHnXnaBvbnPDl+NKQQQxPFyCbVyTcJ9XMXO2KIwBDDNva9Vrm+2b3PVFAOW0TddGu4EwuVsbiWs+Mblphxc4GyhoeplXXWMfI8fRN6om9WCqDlxoMmacNm7y43Txvp5/Gpx7bkuAHvKs88gH9anbs8ogzD9LebI5sr jsmith@aol.com"
    sudo: yes
    docker: yes
```

In the above, both users will be sudo users (no password). jsmith will be a docker user (can run `docker ps` without sudo).


Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: instance.user-add
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

