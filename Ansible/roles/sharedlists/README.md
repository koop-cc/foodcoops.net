Sharedlists
===========

This role installs [Sharedlists](https://github.com/foodcoops/sharedlists), a simple rails driven database for managing multiple product lists of various suppliers.

# Running the role

1. Run the playbook with:
    ```Shell
    ansible-playbook playbooks/sharedlists.yml
    ```
2. Under some [conditions](https://github.com/rails/webpacker/issues/531) the role fails when "assets precompile" is executed. Just try to run the role again.
