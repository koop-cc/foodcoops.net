Foodsoft Configuration
======================

This role provides the following tasks:
- Adapt a stock Foodsoft installation to the need of foodcoops.net.
- Add or remove a Foodsoft instance from the multicoop setup.

Dependencies
------------

Before you use this role make sure the following roles did run successfully on the server:
- [basic-server](../basic-server)
- [mariadb](../mariadb)
- [nginx](../nginx)
- [postfix](../postfix)
- [sharedlists](../sharedlists)

Customization
-------------

We [adapted](tasks/customizations.yml) the [stock](https://github.com/foodcoops/foodsoft/) Foodsoft version to our needs:

- Disable the logging of IP addresses
- Enforce stronger passwords
- Allow decimal numbers in transaction collections
