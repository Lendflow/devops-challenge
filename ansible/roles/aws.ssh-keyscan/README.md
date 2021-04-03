aws.ssh-keyscan
=========

This role runs `ssh-keyscan` against all instances found in an AWS region. Can either use either `aws-system-log` or `ssh-keyscan` methods.

Requirements
------------

- None

Role Variables
--------------

- `ssh_keyscan_scrape_method` - The SSH scan method to use. Required. Can either use either `aws-system-log` or `ssh-keyscan` methods.
- `ssh_keyscan_upload` - Defines if we upload the known_hosts and config files. If defined, upload. If not, skip.
- `ssh_keyscan_s3_bucket` - The S3 bucket to use. When `ssh_keyscan_upload` is defined, required.
- `ssh_keyscan_s3_prefix` - The S3 prefix to use. Defaults to `ssh-keyscan`.
- `region` - The AWS region to use. Required.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: localhost
  connection: local
  gather_facts: yes
  become: no
- roles:
    - role: aws.ssh-keyscan
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

