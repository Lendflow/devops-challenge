service.docker
=========

This role installs Docker on an Ubuntu (maybe Debian?) system.

Requirements
------------

- Ubuntu.
- SystemD.

Role Variables
--------------

- `docker_conf` - the Docker config filename, such as `volume-mount-docker.conf`. See the templates directory for examples.
- `restart_docker` - when defined, restarts the Docker service.
- `install_docker_compose` - when defined, installs docker-compose.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: server_group
- roles:
    - role: service.docker
```

License
-------

BSD

Author Information
------------------

EXAMPLE - https://example.org

