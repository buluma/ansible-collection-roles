Ansible Role: LEMP Stack
============================

This role will install the LEMP Stack. Nginx, MySQL, PHP-FPM.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

Dependencies
------------

None.

Example Playbook
----------------

    - name: Install LEMP Stack
      hosts: all
      become: true
      become_method: sudo
      roles:
        - mosufy.lemp-stack

License
-------

This codebase is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)

Author Information
------------------

For any issues with installation or getting this to work, send an email to: [mosufy@gmail.com](mailto:mosufy@gmail.com)