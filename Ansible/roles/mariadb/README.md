MariaDB
=======

This role installs a MariaDB database server.

The following tasks are included:
- Install a [Munin](https://munin-monitoring.org) and a [Monit](https://mmonit.com/monit/) plugin for monitoring
- Run weekly database optimizations
- Optional: Install [phpMyAdmin](https://www.phpmyadmin.net/)

# Running the role

1. Run the playbook with:
    ```Shell
    ansible-playbook playbooks/mariadb.yml
    ```
1. If you intend to install phpMyAdmin just run the playbook with this tag:
    ```Shell
    ansible-playbook playbooks/mariadb.yml --tags never,phpmyadmin
