service.nginx-reverse-proxy
=========

This role installs an NGINX reverse proxy service using Docker and SystemD.

Requirements
------------

- Ubuntu.
- Docker.
- SystemD.

Role Variables
--------------

- `volume_mount` - The persistent disk or volume mount to use. If you are not using a persistent volume or data disk, any path will do where you want to store configs/data.
- `nginx_reverse_proxy_config` - The NGINX reverse proxy config template to use. Required.
- `nginx_docker_image` - The NGINX Docker image to use. Defaults to `nginx:stable`.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: service.nginx-reverse-proxy
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

