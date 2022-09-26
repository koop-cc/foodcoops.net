Ressources
==========

# Online services

- Database management with phpMyAdmin: https://dbadmin.foodcoops.net
- Mailinglist management: https://lists.foodcoodps.net
- Sharedlists web service: https://sharedlists.systemausfall.org
- Status page for admins: https://status.foodcoops.net/status/admin
- Status page for user: https://status.foodcoops.net
- Status page dashboard: https://status.foodcoops.net/dashboard

# Servers

We are running these two servers:

| name | services |
|------|----------|
| focone | foodsoft, sharedlists, phpMyAdmin |
| fc-helper | Uptime Kuma, Backups |

To gain access just paste these configuration snippets to you `~/.ssh/config`:
```Shell
Host focone
Hostname app.foodcoops.net
Port 2243
User root

Host fc-helper
Hostname helper.foodcoops.net
Port 2225
User root
```

# Password database

A lot of login credentials are saved in a keepassxc password database.
