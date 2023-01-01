[![Build Status](https://drone.element-networks.nl/api/badges/Ansible/role-foreman/status.svg)](https://drone.element-networks.nl/Ansible/role-foreman)
# Foreman configuration by Ansible
This role provides a means to provision a Foreman or Satellite server with an organization and some content

This role requires the following Ansible Collections in order to work:

* 'theforeman.foreman' 3.4.0 or higher
* 'ansible.utils' 2.6.0 or higher
* 'ansible.posix' 1.4.0 or higher

Tested with Ansible 2.12 and higher

This role supports Foreman 3.2 / Katello 4.4 and up or Red Hat Satellite 6.11 and up.

Other requirements on the Ansible controller:

* python-netaddr (for subnet related tasks)

Check out the [example inventory and playbooks](../playbooks) for some guidance! Or read my [blog post](https://theforeman.org/2020/10/foreman-config-as-code.html).

## Satellite Offline installation
If you want to install Satellite via the Offline Installation ISO, make sure you have configured RHEL repo's from a Installation ISO or mirror as well.

## Content Views (CV), Composite Content Views (COV) and publishing
When this role is used to create new content views and composites, the following strategy is applied:

* Content views are created with the same name as the product they contain
* Repositories that are newly created will be synchronized after creation (asynchronously)
* Composite content views that are newly created will be promoted to all lifecycle environments in the organization

The idea behind this is that COVs are the only things that are associated with clients. The Base CVs themselves are only present in the Library and should not be promoted to any other environment.

All created COVs have auto_publish enabled and sample playbooks to 'tag' a new version and publish it are provided.

## Host Discovery
For Host discovery, register the following records in DNS to allow the FDI to report to the correct server:

* For Foreman servers:
```
_x-foreman._tcp.dev.example.com 600 IN  SRV 0 5 443 foreman.dev.example.com
```

* For Foreman Smart Proxies:
```
_x-foreman._tcp.dev.example.com 600 IN  SRV 0 5 8443 fm-proxy.dev.example.com
```

## Installing Smart Proxies
Some of the settings used for Smart Proxies are shared with the Foreman server. In order to prevent duplicate
settings, the following inventory is suggested

```
[foreman]
foreman.infra.example.com

[foreman_proxies]
fm-proxy.dev.example.com

[foreman_infra]

[foreman_infra:children]
foreman
foreman_proxies
```

Then put all the Global settings for Foreman in the group_vars for foreman_infra, which will then be available
to both the Server and the Proxies. You can then create host_vars for each Foreman system (Server or Proxies) that contain the instance specific settings.

## Limitations, bugs and workarounds
Sometimes the installer is unable to succesfully complete the configuration of the Foreman services. The Ansible tasks have been configured (unless you're running a version of Foreman/Satellite that does not support --detailed-exitcodes) to trigger on that.

When an issue occurs, you can follow the following steps to localize the issue:

* Run ```foreman-installer``` manually, no arguments are required. This will give a general direction where to look
* Check the logs in /var/log/foreman-installer
* Restart the Foreman services, this will sometimes 'reset' things after which Foreman will succesfully wrap up the installer.

For specific things, see below

### Information about Deployment, Discovery and UEFI vs. BIOS vs. iPXE
Testing has shown that various settings can have an effect on whether a host can boot from the network.

We have tested the following setups:

* Discovery:
  * KVM
    * BIOS: works with default settings configured by this role. Can also be used with iPXE.
    * UEFI: is a bit iffy, you might run into some issues trying to load the FDI from PXE as TFTP will timeout. iPXE works fine.

  * HyperV:
    * Gen1 (BIOS): works with the default settings configured. Can also be used with iPXE.
    * Gen2 (UEFI): requires iPXE, you must disable SecureBoot.

* OS Deployment:
  * KVM
    * BIOS: works with default settings configured by this role. Can also be used with iPXE.
    * UEFI: use ```pxe_loader: 'Grub2 UEFI'``` with default settings by this role. Can also be used with iPXE.

  * HyperV:
    * Gen1 (BIOS): works with the default settings configured by this role up to CentOS7, CentOS8 and up requires Gen2.
    * Gen2 (UEFI): requires iPXE, you must disable SecureBoot.

* Boot local
  * KVM
    * BIOS: works fine. Can also used with iPXE.
    * UEFI: use ```pxe_loader: 'Grub2 UEFI'``` with default settings by this role. iPXE may hang in UEFI system menu: https://community.theforeman.org/t/ipxe-does-not-boot-local-hard-disk-on-uefi/21437

  * HyperV:
    * Gen1: works fine.
    * Gen2: works fine, you must disable SecureBoot.

To enable iPXE set ```foreman_deploy_ipxe: true``` and use ```pxe_loader: 'None'``` for your OSes

### Bug: Error creating OSes
Remove all the OSes from Hosts -> Operating systems (you can't delete the one where the foreman server is in)

### Limitation: Resources with passwords always change
Because the Foreman modules can't see the current password set for password fields, these cannot be compared.

Therefore these always changes (Operating systems, Upstream repo credentials etc.). This can cause extra actions
depending on the resource changed. This hasn't proven problematic so far, but the play execution can take a
little longer because of it.

### Limitation: Host groups always use the first partition table in the list
As the Host Groups are the combined result of Activation Keys, Operating Systems and Lifecycles, the amount of
configurability is limited. At time of writing the role will configure all hostgroups with the same Partition Table.

An example for a deployment with a different Partition Table is shown below:

```
# The partition table below is set to ignore
# all disks except the first one for automatic partitioning.
# Please note that it is does not autodetect disk types (vd or sd)
# so you'll have to hardcode the disk to be used
foreman_partition_tables:
  - name: 'Kickstart default first disk only'
    os_family: 'Redhat'
    layout: |
      <%#
      kind: ptable
      name: Kickstart default first disk only
      model: Ptable
      description: Managed by Ansible, your changes will be lost
      %>
      zerombr
      clearpart --all --initlabel
      ignoredisk --use-only=sda
      autopart <%= host_param('autopart_options') %>

foreman_operating_systems:
  - name: 'CentOS'
    major_version: 7
    arch:
     - 'x86_64'
    os_family: 'Redhat'
    kickstart: true
    kickstart_repo: 'CentOS7-Base'
    partitions:
      - 'Kickstart default first disk only'
    root_pass: 'some_password'
    parameters:
      - name: 'autopart_options'
        value: '--nohome'
```

