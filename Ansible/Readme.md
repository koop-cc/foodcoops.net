# Foodcoops.net Ansible deployment

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
## Roles overview
| Name | Description |
|------|-------------|
| basic-server | Initial setup for a new server |
| nginx | Installation and configuration of Nginx |
| mariadb | Installation and configuration of MariaDB |
| postfix | Installation and configuration of Postfix for use with a real mail domain |
| sharedlists | Installation, configuration, updating of sharedlists |
| foodsoft | Installation, configuration, updating of the Foodsoft |


## Common tasks
### Adding a new foodcoop
1. Gather all [information](https://foodcoops.net/.global-foodsoft-platform/#request-a-new-instance)
1. Add the data to `host_vars/focone.yml` in the section `foodcoops`. Just follow the existing pattern.
1. Upload the changes to our Git repository.
1. Execute the playbook with:
   ```shell
   ansible-playbook playbooks/foodsoft.yml --tags never,foodcoop_add
   ```
1. Immediately login with `admin` / `secret` and change the user details and password. The `admin` user should become the user account of the first contact person, so use their email address here. We do not want to encourage an unused `admin` account.
1. You may want to pre-set some configuration if you know a bit more about the foodcoop. It's always helpful for new foodcoops to have a setup that already reflects their intended use a bit. At least you should set a time zone.
1. Send an email to the foodcoop's contact persons with the url and admin account details.
1. Please also communicate that this platform is run by volunteers from participating food cooperatives and depends on donations.
1. Add the two contact persons to our foodsoft announce mailing list.

### Deleting a foodcoop
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
   ansible-playbook playbooks/foodsoft --tags never,foodcoops_delete
   ```
1. Delete the foodcoop's entry from `host_vars/focone.yml`.
1. Upload the changes to our Git repository.
1. Delete the two contact persons from our foodsoft announce mailing list.