Foodcoops.net Ansible deployment
================================

- [Foodcoops.net Ansible deployment](#foodcoopsnet-ansible-deployment)
- [Introduction](#introduction)
- [Roles overview](#roles-overview)
- [Common tasks](#common-tasks)
  - [Check and restart a service](#check-and-restart-a-service)
  - [Adding a new foodcoop](#adding-a-new-foodcoop)
  - [Deleting a foodcoop](#deleting-a-foodcoop)
  - [Adding a member to the hosting team](#adding-a-member-to-the-hosting-team)
  - [Run rails commands](#run-rails-commands)
  - [Recreating the demo database](#recreating-the-demo-database)
  - [List the date of latest activity per instance](#list-the-date-of-latest-activity-per-instance)

# Introduction
In this folder you'll find a couple of [Ansible](https://www.ansible.com) roles to setup and manage the
infrastructure for the [global Foodsoft platform](https://foodcoops.net/global-foodsoft-platform/) of
[foodcoops.net](https://foodcoops.net).

To use this roles you have to install these packages:
```shell
apt install ansible ansible-mitogen
```

We don't want to save internal data as clear text in this roles. For data encryption we make use of
[ansible-vault](https://docs.ansible.com/ansible/latest/cli/ansible-vault.html). To complete your Ansible setup just create a file called `.vault_pass` at the same level as this Readme file and include the vault password from our password database in this file. All variables that make use of the vault start with a prefix `vault_`. You will find them in a role's subfolder at `vars/main.yml`. To edit such a variable us a command like this: `ansible-vault edit roles/foodsoft/vars/main.yml`.

Have a look at a role's directory to find out more details on how we implement the global Foodsoft platform.

You can execute a role by using the corresponding [playbook](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html) which are named equally:
```shell
ansible-playbook playbooks/foodsoft.yml
```
# Roles overview
| Name | Description |
|------|-------------|
| basic-server | Initial setup for a new server |
| foodsoft | Installation, configuration, updating of the Foodsoft, uses [upstream](https://github.com/foodcoops/foodsoft) version |
| mariadb | Installation and configuration of MariaDB |
| nginx | Installation and configuration of Nginx |
| postfix | Installation and configuration of Postfix for use with a real mail domain |
| sharedlists | Installation, configuration, updating of sharedlists, uses [Kidhab fork](https://github.com/kidhab/sharedlists) |
| uptime-kuma | Installation of Uptime Kuma a monitoring solution |

# Common tasks
## Check and restart a service
We use different (systemd) services at focone:

| Name | Description |
|------|-------------|
| foodsoft-web | Foodsoft web interface |
| foodsoft-smtp | Foodsoft smtp server for incoming emails |
| foodsoft-resque | Redis-based [backend](https://github.com/resque/resque) for background jobs |
| sharedlists-web | Sharedlists web interface |
| sharedlists-smtp | Sharedlists smtp server for article updates by email |

You can check the status of a service with a command like this:
```shell
systemctl status foodsoft-web
```
If something seams wrong have a look at the log file, e.g:
```shell
journalctl -u foodsoft-web
```
There is also the [Monit](https://mmonit.com/monit/) output that tells you what's going on:
```Shell
monit status
```
Monit tries to restart a service in case of a failure. You can restart a service manually with systemd:
```shell
systemctl restart foodsoft-web
```

## Adding a new foodcoop
1. Gather all [information](https://foodcoops.net/.global-foodsoft-platform/#request-a-new-instance)
1. Add the data to `host_vars/focone.yml` in the section `foodcoops`. Just follow the existing pattern.
2. Some custom [configuration](roles/foodsoft/Configuration.md) settings are available. At the moment this the Ansible role supports:
   | Setting | Value |
   |---------|-------|
   | `stop_ordering_under` | int |
   | `use_apple_points` | bol |
   | `use_nick` | bol |
3. Upload the changes to our Git repository.
4. Execute the playbook with:
   ```shell
   ansible-playbook playbooks/foodsoft.yml --tags never,foodcoop_add
   ```
5. Immediately login with `admin` / `secret1234` and change the user details and password. The `admin` user should become the user account of the first contact person, so use their email address here. We do not want to encourage an unused `admin` account.
6. You may want to pre-set some configuration if you know a bit more about the foodcoop. It's always helpful for new foodcoops to have a setup that already reflects their intended use a bit. At least you should set a time zone.
7. Send an email to the foodcoop's contact persons with the url and admin account details.
8. Please also communicate that this platform is run by volunteers from participating food cooperatives and depends on donations.
9.  Add the two contact persons to our foodsoft announce mailing list.

## Deleting a foodcoop
If the deletion of a foocoop is requested follow these steps:

1. Find the foodcoops's configuration at `host_vars/focone.yml`. Enter another entry called `deleted: true` to the array:
   ```yaml
   foodcoops:
     - name: mycoop
       database: foodsoft_mycoop
       deleted: true
   ```
1. Execute the playbook:
   ```shell
   ansible-playbook playbooks/foodsoft --tags never,foodcoop_delete
   ```
   Removing a Foodcoop will result in a restart of the Foodsoft service. Please execute the playbook in the late evening or preferably during the night to not disturb our users.
1. Delete the foodcoop's entry from `host_vars/focone.yml`.
1. Upload the changes to our Git repository.
1. Delete the two contact persons from our foodsoft announce mailing list.

## Adding a member to the hosting team
- Add to Github [operations team](https://github.com/orgs/foodcoops/teams/operations)
- Add to relevant [mailing lists](https://lists.foodcoops.net) (support@lists.foodcoops.net  and foodcoops-announce@lists.foodcoops.net)
- Obtain user's SSH key and verify it from a Github gist, Keybase or a video call.
- Add SSH key file to `roles/basic-server/ssh_authorized_keys/admin` and start ansible:
    ```shell
    ansible-playbook playbooks/basic-server.yml --limit focone
    ```
- Add email address to `/etc/postfix/conf.d/virtual_aliases`, save the file and run postmap:
    ```shell
    postmap cdb:virtual_aliases
    ```

## Run rails commands
Usually you have to pass at least these environment variables to make `rails` [commands](https://guides.rubyonrails.org/command_line.html) work:
- `RAILS_ENV`
- `REDIS_URL` (Foodsoft only)
- `SECRET_KEY_BASE`
  
Additionally your need to run `rails` in the context of `rbenv`. This results in a very long command line argument.  You may use the bash [aliases](https://github.com/foodcoops/foodcoops.net/commit/a3b9818644e14eaa51af4a4e5db8d38a4474f59a) `foodsoftctl` and `sharedlistsctl` to shorten the `rails` commands.

## Recreating the demo database
It can sometimes be useful to manually reset the demo instance with a new database, seeded from `small.en`. Run the following command as the Foodsoft system user:
```shell
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 DATABASE_URL=mysql2://foodsoft:$DATABASE_PASSWORD@localhost/foodsoft_demo \  
  foodsoftctl db:purge db:schema:load db:seed:small.en && foodsoftctl tmp:cache:clear
```

## List the date of latest activity per instance
You can intenify the date of the latest user activity of all Foodsoft instances:
```Shell
cd /opt/foodsoft

su _foodsoft

foodsoftctl r 'FoodsoftConfig.foodcoops.each{|s| FoodsoftConfig.select_foodcoop(s) ; \
  puts "#{User.maximum(:last_activity).rfc3339} #{s}"}' | sort
```
