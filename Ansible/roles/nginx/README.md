Nginx
=====

This role installs Nginx together with [dehydrated](https://dehydrated.io/) to obtain certificates from [Let's Encrypt](https://letsencrypt.org/).

The following tasks are included:
- Setup fail2ban to handle [request limits](https://nginx.org/en/docs/http/ngx_http_limit_req_module.html)
- Install a [Munin](https://munin-monitoring.org) plugin for monitoring
- Setup a cron job to daily purge IP addresses from Nginx's log files

# Running the role

Run the playbook with:
```Shell
ansible-playbook playbooks/nginx.yml
```
