# Hardening - the Ansible role

An [Ansible](https://www.ansible.com/) role to make a AlmaLinux, Debian, or
Ubuntu server a bit more secure.
[systemd edition](https://freedesktop.org/wiki/Software/systemd/).

Requires Ansible >= 2.10.

Available on
[Ansible Galaxy](https://galaxy.ansible.com/konstruktoid/hardening).

```console
Do not use this role without first testing in a non-operational environment.
```

[AlmaLinux 8](https://almalinux.org/),
[Debian 11](https://www.debian.org/) and
[Ubuntu 20.04](https://ubuntu.com/) are supported platforms.

[Ubuntu 22.04](https://wiki.ubuntu.com/Releases) are in a testing phase.

## Dependencies

None.

## Examples

### Playbook

```yaml
---
- hosts: localhost
  any_errors_fatal: true
  tasks:
    - name: include the hardening role
      include_role:
        name: konstruktoid.hardening
      vars:
        block_blacklisted: true
        sshd_admin_net:
          - 10.0.2.0/24
          - 192.168.0.0/24
          - 192.168.1.0/24
        suid_sgid_permissions: false
...
```

### ansible-pull with git checkout

```yaml
---
- hosts: localhost
  any_errors_fatal: true
  tasks:
    - name: install git
      become: 'yes'
      package:
        name: git
        state: present

    - name: checkout konstruktoid.hardening
      become: 'yes'
      ansible.builtin.git:
        repo: 'https://github.com/konstruktoid/ansible-role-hardening'
        dest: /etc/ansible/roles/konstruktoid.hardening
        version: master

    - name: include the hardening role
      include_role:
        name: konstruktoid.hardening
      vars:
        block_blacklisted: true
        sshd_admin_net:
          - 10.0.2.0/24
          - 192.168.0.0/24
          - 192.168.1.0/24
        suid_sgid_permissions: false
...
```

## Note regarding Debian family UFW firewall rules

Instead of resetting `ufw` every run and by doing so causing network traffic
disruption, the role deletes every `ufw` rule without
`comment: ansible managed` task parameter and value.

The role also sets default deny policies, which means that firewall rules
needs to be created for any additional ports except those specified in
the `sshd_port` and `ufw_outgoing_traffic` variables.

## Task Execution and Structure

See [STRUCTURE.md](STRUCTURE.md) for a detailed map regarding all tasks
and the role structure.

## Role testing

See [TESTING.md](TESTING.md).

## Role Variables with defaults

### ./defaults/main/auditd.yml

```yaml
auditd_apply_audit_rules: 'yes'
auditd_action_mail_acct: root
auditd_admin_space_left_action: suspend
auditd_disk_error_action: suspend
auditd_disk_full_action: suspend
auditd_max_log_file: 8
auditd_max_log_file_action: keep_logs
auditd_mode: 1
auditd_num_logs: 5
auditd_space_left: 75
auditd_space_left_action: email
grub_audit_backlog_cmdline: audit_backlog_limit=8192
grub_audit_cmdline: audit=1
```

### ./defaults/main/compilers.yml

```yaml
compilers:
  - as
  - cargo
  - cc
  - cc-[0-9]*
  - clang-[0-9]*
  - gcc
  - gcc-[0-9]*
  - go
  - make
  - rustc
```

### ./defaults/main/dns.yml

```yaml
dns: 127.0.0.1 1.1.1.1
fallback_dns: 9.9.9.9 1.0.0.1
dnssec: allow-downgrade
dns_over_tls: opportunistic
```

### ./defaults/main/firewall.yml

```yaml
ufw_outgoing_traffic:
  - 22
  - 53
  - 80
  - 123
  - 443
  - 853
```

### ./defaults/main/limits.yml

```yaml
limit_nofile_hard: 1024
limit_nofile_soft: 512
limit_nproc_hard: 1024
limit_nproc_soft: 512
```

### ./defaults/main/misc.yml

```yaml
install_aide: 'yes'
reboot_ubuntu: false
redhat_rpm_key:
  - 567E347AD0044ADE55BA8A5F199E2F91FD431D51
  - 47DB287789B21722B6D95DDE5326810137017186
epel7_rpm_keys:
  - 91E97D7C4A5E96F17F3E888F6A2FAEA2352C64E5
epel8_rpm_keys:
  - 94E279EB8D8F25B21810ADF121EA45AB2F86D6A1
```

### ./defaults/main/module_blocklists.yml

```yaml
block_blacklisted: false
fs_modules_blocklist:
  - cramfs
  - freevxfs
  - hfs
  - hfsplus
  - jffs2
  - squashfs
  - udf
  - vfat
misc_modules_blocklist:
  - bluetooth
  - bnep
  - btusb
  - can
  - cpia2
  - firewire-core
  - floppy
  - n_hdlc
  - net-pf-31
  - pcspkr
  - soundcore
  - thunderbolt
  - usb-midi
  - usb-storage
  - uvcvideo
  - v4l2_common
net_modules_blocklist:
  - atm
  - dccp
  - sctp
  - rds
  - tipc
```

### ./defaults/main/mount.yml

```yaml
hide_pid: 2
process_group: root
```

### ./defaults/main/ntp.yml

```yaml
fallback_ntp: 2.ubuntu.pool.ntp.org 3.ubuntu.pool.ntp.org
ntp: 0.ubuntu.pool.ntp.org 1.ubuntu.pool.ntp.org
```

### ./defaults/main/packages.yml

```yaml
system_upgrade: 'yes'
packages_blocklist:
  - apport*
  - autofs
  - avahi*
  - avahi-*
  - beep
  - git
  - pastebinit
  - popularity-contest
  - prelink
  - rpcbind
  - rsh*
  - rsync
  - talk*
  - telnet*
  - tftp*
  - whoopsie
  - xinetd
  - yp-tools
  - ypbind
packages_debian:
  - acct
  - apparmor-profiles
  - apparmor-utils
  - apt-show-versions
  - audispd-plugins
  - auditd
  - cracklib-runtime
  - debsums
  - gnupg2
  - haveged
  - libpam-apparmor
  - libpam-cap
  - libpam-modules
  - libpam-pwquality
  - libpam-tmpdir
  - lsb-release
  - needrestart
  - openssh-server
  - postfix
  - rkhunter
  - rsyslog
  - sysstat
  - tcpd
  - vlock
  - wamerican
packages_redhat:
  - audispd-plugins
  - audit
  - cracklib
  - gnupg2
  - haveged
  - libpwquality
  - openssh-server
  - needrestart
  - postfix
  - psacct
  - rkhunter
  - rsyslog
  - rsyslog-gnutls
  - vlock
  - words
packages_ubuntu:
  - fwupd
  - secureboot-db
```

### ./defaults/main/password.yml

```yaml
crypto_policy: FIPS
pwquality_config:
  dcredit: -1
  dictcheck: 1
  difok: 8
  enforcing: 1
  lcredit: -1
  maxclassrepeat: 4
  maxrepeat: 3
  minclass: 4
  minlen: 15
  ocredit: -1
  ucredit: -1
```

### ./defaults/main/sshd.yml

```yaml
sshd_accept_env: LANG LC_*
sshd_admin_net:
  - 192.168.0.0/24
  - 192.168.1.0/24
sshd_allow_agent_forwarding: 'no'
sshd_allow_groups: sudo
sshd_allow_tcp_forwarding: 'no'
sshd_authentication_methods: any
sshd_banner: /etc/issue.net
sshd_challenge_response_authentication: 'no'
sshd_ciphers: chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr
sshd_client_alive_count_max: 1
sshd_client_alive_interval: 200
sshd_compression: 'no'
sshd_gssapi_authentication: 'no'
sshd_hostbased_authentication: 'no'
sshd_ignore_user_known_hosts: 'yes'
sshd_kerberos_authentication: 'no'
sshd_kex_algorithms: curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
sshd_log_level: VERBOSE
sshd_login_grace_time: 20
sshd_macs: hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
sshd_max_auth_tries: 3
sshd_max_sessions: 3
sshd_max_startups: 10:30:60
sshd_password_authentication: 'no'
sshd_permit_empty_passwords: 'no'
sshd_permit_root_login: 'no'
sshd_permit_user_environment: 'no'
sshd_port: 22
sshd_print_last_log: 'yes'
sshd_print_motd: 'no'
sshd_rekey_limit: 512M 1h
sshd_strict_modes: 'yes'
sshd_subsystem: sftp internal-sftp
sshd_tcp_keep_alive: 'no'
sshd_use_dns: 'no'
sshd_use_pam: 'yes'
sshd_x11_forwarding: 'no'
```

### ./defaults/main/suid_sgid_blocklist.yml

```yaml
suid_sgid_permissions: true
suid_sgid_blocklist:
  - /bin/ansible-playbook
  - /bin/ar
  - /bin/at
  - /bin/awk
  - /bin/base32
  - /bin/base64
  - /bin/bash
  - /bin/busctl
  - /bin/busybox
  - /bin/bzip2
  - /bin/c89
  - /bin/c99
  - /bin/cancel
  - /bin/cat
  - /bin/chage
  - /bin/chfn
  - /bin/chmod
  - /bin/chown
  - /bin/chsh
  - /bin/cmp
  - /bin/column
  - /bin/comm
  - /bin/cowsay
  - /bin/cowthink
  - /bin/cp
  - /bin/cpan
  - /bin/cpio
  - /bin/crontab
  - /bin/csplit
  - /bin/curl
  - /bin/cut
  - /bin/dash
  - /bin/date
  - /bin/dd
  - /bin/diff
  - /bin/dmesg
  - /bin/dnf
  - /bin/ed
  - /bin/env
  - /bin/eqn
  - /bin/ex
  - /bin/expand
  - /bin/file
  - /bin/find
  - /bin/flock
  - /bin/fmt
  - /bin/fold
  - /bin/fusermount
  - /bin/gawk
  - /bin/gcc
  - /bin/grep
  - /bin/gzip
  - /bin/head
  - /bin/hexdump
  - /bin/iconv
  - /bin/install
  - /bin/ionice
  - /bin/ip
  - /bin/join
  - /bin/journalctl
  - /bin/less
  - /bin/ln
  - /bin/loginctl
  - /bin/look
  - /bin/mail
  - /bin/make
  - /bin/man
  - /bin/mksh
  - /bin/mksh-static
  - /bin/more
  - /bin/mount
  - /bin/msgattrib
  - /bin/msgcat
  - /bin/msgconv
  - /bin/msgfilter
  - /bin/msgmerge
  - /bin/msguniq
  - /bin/mv
  - /bin/nano
  - /bin/nc
  - /bin/newgrp
  - /bin/nice
  - /bin/nl
  - /bin/nohup
  - /bin/nroff
  - /bin/nsenter
  - /bin/ntfs-3g
  - /bin/od
  - /bin/openssl
  - /bin/openvt
  - /bin/paste
  - /bin/perl
  - /bin/pic
  - /bin/ping
  - /bin/ping6
  - /bin/pkexec
  - /bin/pr
  - /bin/rbash
  - /bin/readelf
  - /bin/red
  - /bin/rev
  - /bin/rpm
  - /bin/rpmquery
  - /bin/rsync
  - /bin/run-parts
  - /bin/rview
  - /bin/scp
  - /bin/script
  - /bin/sed
  - /bin/setarch
  - /bin/sftp
  - /bin/sg
  - /bin/sh
  - /bin/shuf
  - /bin/soelim
  - /bin/sort
  - /bin/split
  - /bin/sqlite3
  - /bin/ssh
  - /bin/ssh-keygen
  - /bin/ssh-keyscan
  - /bin/stdbuf
  - /bin/strings
  - /bin/su
  - /bin/systemctl
  - /bin/systemd-resolve
  - /bin/tac
  - /bin/tail
  - /bin/tar
  - /bin/taskset
  - /bin/tbl
  - /bin/tee
  - /bin/tic
  - /bin/time
  - /bin/timedatectl
  - /bin/timeout
  - /bin/top
  - /bin/troff
  - /bin/ul
  - /bin/umount
  - /bin/unexpand
  - /bin/uniq
  - /bin/unshare
  - /bin/vi
  - /bin/view
  - /bin/wall
  - /bin/watch
  - /bin/wc
  - /bin/wget
  - /bin/whiptail
  - /bin/write
  - /bin/xargs
  - /bin/xz
  - /bin/yum
  - /bin/zip
  - /bin/zsoelim
  - /sbin/arp
  - /sbin/bridge
  - /sbin/capsh
  - /sbin/chroot
  - /sbin/dmidecode
  - /sbin/dmsetup
  - /sbin/ip
  - /sbin/ldconfig
  - /sbin/logsave
  - /sbin/mount.nfs
  - /sbin/ping
  - /sbin/ping6
  - /sbin/service
  - /sbin/ss
  - /sbin/start-stop-daemon
  - /sbin/sysctl
  - /sbin/tcpdump
  - /sbin/update-alternatives
  - /sbin/vigr
  - /sbin/vipw
  - /usr/bin/ansible-playbook
  - /usr/bin/apt
  - /usr/bin/apt-get
  - /usr/bin/ar
  - /usr/bin/at
  - /usr/bin/awk
  - /usr/bin/base32
  - /usr/bin/base64
  - /usr/bin/basenc
  - /usr/bin/bash
  - /usr/bin/bsd-write
  - /usr/bin/busctl
  - /usr/bin/busybox
  - /usr/bin/bzip2
  - /usr/bin/c89
  - /usr/bin/c99
  - /usr/bin/cancel
  - /usr/bin/cat
  - /usr/bin/chage
  - /usr/bin/chfn
  - /usr/bin/chmod
  - /usr/bin/chown
  - /usr/bin/chsh
  - /usr/bin/cmp
  - /usr/bin/column
  - /usr/bin/comm
  - /usr/bin/cowsay
  - /usr/bin/cowthink
  - /usr/bin/cp
  - /usr/bin/cpan
  - /usr/bin/cpio
  - /usr/bin/crontab
  - /usr/bin/csplit
  - /usr/bin/curl
  - /usr/bin/cut
  - /usr/bin/dash
  - /usr/bin/date
  - /usr/bin/dd
  - /usr/bin/diff
  - /usr/bin/dig
  - /usr/bin/dmesg
  - /usr/bin/dnf
  - /usr/bin/dpkg
  - /usr/bin/ed
  - /usr/bin/env
  - /usr/bin/eqn
  - /usr/bin/ex
  - /usr/bin/expand
  - /usr/bin/file
  - /usr/bin/find
  - /usr/bin/flock
  - /usr/bin/fmt
  - /usr/bin/fold
  - /usr/bin/ftp
  - /usr/bin/fusermount
  - /usr/bin/gawk
  - /usr/bin/gcc
  - /usr/bin/gem
  - /usr/bin/git
  - /usr/bin/grep
  - /usr/bin/gzip
  - /usr/bin/hd
  - /usr/bin/head
  - /usr/bin/hexdump
  - /usr/bin/iconv
  - /usr/bin/install
  - /usr/bin/ionice
  - /usr/bin/ip
  - /usr/bin/irb
  - /usr/bin/join
  - /usr/bin/journalctl
  - /usr/bin/less
  - /usr/bin/ln
  - /usr/bin/loginctl
  - /usr/bin/look
  - /usr/bin/ltrace
  - /usr/bin/mail
  - /usr/bin/make
  - /usr/bin/man
  - /usr/bin/mawk
  - /usr/bin/mksh
  - /usr/bin/mlocate
  - /usr/bin/more
  - /usr/bin/mount
  - /usr/bin/msgattrib
  - /usr/bin/msgcat
  - /usr/bin/msgconv
  - /usr/bin/msgfilter
  - /usr/bin/msgmerge
  - /usr/bin/msguniq
  - /usr/bin/mtr
  - /usr/bin/mv
  - /usr/bin/nano
  - /usr/bin/nawk
  - /usr/bin/nc
  - /usr/bin/newgrp
  - /usr/bin/nice
  - /usr/bin/nl
  - /usr/bin/nohup
  - /usr/bin/nroff
  - /usr/bin/nsenter
  - /usr/bin/ntfs-3g
  - /usr/bin/od
  - /usr/bin/openssl
  - /usr/bin/openvt
  - /usr/bin/paste
  - /usr/bin/pdb
  - /usr/bin/perf
  - /usr/bin/perl
  - /usr/bin/pic
  - /usr/bin/pico
  - /usr/bin/ping
  - /usr/bin/ping6
  - /usr/bin/pkexec
  - /usr/bin/pr
  - /usr/bin/python
  - /usr/bin/rake
  - /usr/bin/rbash
  - /usr/bin/readelf
  - /usr/bin/red
  - /usr/bin/rev
  - /usr/bin/rlogin
  - /usr/bin/rpm
  - /usr/bin/rpmquery
  - /usr/bin/rsync
  - /usr/bin/ruby
  - /usr/bin/run-mailcap
  - /usr/bin/run-parts
  - /usr/bin/rview
  - /usr/bin/rvim
  - /usr/bin/scp
  - /usr/bin/screen
  - /usr/bin/script
  - /usr/bin/sed
  - /usr/bin/setarch
  - /usr/bin/sftp
  - /usr/bin/sg
  - /usr/bin/sh
  - /usr/bin/shuf
  - /usr/bin/snap
  - /usr/bin/soelim
  - /usr/bin/sort
  - /usr/bin/split
  - /usr/bin/sqlite3
  - /usr/bin/ss
  - /usr/bin/ssh
  - /usr/bin/ssh-keygen
  - /usr/bin/ssh-keyscan
  - /usr/bin/stdbuf
  - /usr/bin/strace
  - /usr/bin/strings
  - /usr/bin/su
  - /usr/bin/systemctl
  - /usr/bin/systemd-resolve
  - /usr/bin/tac
  - /usr/bin/tail
  - /usr/bin/tar
  - /usr/bin/taskset
  - /usr/bin/tbl
  - /usr/bin/tee
  - /usr/bin/telnet
  - /usr/bin/tic
  - /usr/bin/time
  - /usr/bin/timedatectl
  - /usr/bin/timeout
  - /usr/bin/tmux
  - /usr/bin/top
  - /usr/bin/traceroute6.iputils
  - /usr/bin/troff
  - /usr/bin/ul
  - /usr/bin/umount
  - /usr/bin/unexpand
  - /usr/bin/uniq
  - /usr/bin/unshare
  - /usr/bin/update-alternatives
  - /usr/bin/vi
  - /usr/bin/view
  - /usr/bin/vim
  - /usr/bin/vimdiff
  - /usr/bin/wall
  - /usr/bin/watch
  - /usr/bin/wc
  - /usr/bin/wget
  - /usr/bin/whiptail
  - /usr/bin/whois
  - /usr/bin/write
  - /usr/bin/xargs
  - /usr/bin/xxd
  - /usr/bin/xz
  - /usr/bin/yum
  - /usr/bin/zip
  - /usr/bin/zsoelim
  - /usr/lib/klibc/bin/mksh-static
  - /usr/sbin/arp
  - /usr/sbin/bridge
  - /usr/sbin/capsh
  - /usr/sbin/chroot
  - /usr/sbin/dmidecode
  - /usr/sbin/dmsetup
  - /usr/sbin/ip
  - /usr/sbin/ldconfig
  - /usr/sbin/logsave
  - /usr/sbin/mount.nfs
  - /usr/sbin/ping6
  - /usr/sbin/psad
  - /usr/sbin/service
  - /usr/sbin/ss
  - /usr/sbin/start-stop-daemon
  - /usr/sbin/sysctl
  - /usr/sbin/tcpdump
  - /usr/sbin/update-alternatives
  - /usr/sbin/vigr
  - /usr/sbin/vipw
```

### ./defaults/main/sysctl.yml

```yaml
sysctl_dev_tty_ldisc_autoload: 0
sysctl_net_ipv6_conf_accept_ra_rtr_pref: 0
sysctl_settings:
  fs.protected_fifos: 2
  fs.protected_hardlinks: 1
  fs.protected_symlinks: 1
  fs.suid_dumpable: 0
  kernel.core_uses_pid: 1
  kernel.dmesg_restrict: 1
  kernel.kptr_restrict: 2
  kernel.panic: 60
  kernel.panic_on_oops: 60
  kernel.perf_event_paranoid: 3
  kernel.randomize_va_space: 2
  kernel.sysrq: 0
  kernel.unprivileged_bpf_disabled: 1
  kernel.yama.ptrace_scope: 2
  net.core.bpf_jit_harden: 2
  net.ipv4.conf.all.accept_redirects: 0
  net.ipv4.conf.all.accept_source_route: 0
  net.ipv4.conf.all.log_martians: 1
  net.ipv4.conf.all.rp_filter: 1
  net.ipv4.conf.all.secure_redirects: 0
  net.ipv4.conf.all.send_redirects: 0
  net.ipv4.conf.all.shared_media: 0
  net.ipv4.conf.default.accept_redirects: 0
  net.ipv4.conf.default.accept_source_route: 0
  net.ipv4.conf.default.log_martians: 1
  net.ipv4.conf.default.rp_filter: 1
  net.ipv4.conf.default.secure_redirects: 0
  net.ipv4.conf.default.send_redirects: 0
  net.ipv4.conf.default.shared_media: 0
  net.ipv4.icmp_echo_ignore_broadcasts: 1
  net.ipv4.icmp_ignore_bogus_error_responses: 1
  net.ipv4.ip_forward: 0
  net.ipv4.tcp_challenge_ack_limit: 2147483647
  net.ipv4.tcp_invalid_ratelimit: 500
  net.ipv4.tcp_max_syn_backlog: 20480
  net.ipv4.tcp_rfc1337: 1
  net.ipv4.tcp_syn_retries: 5
  net.ipv4.tcp_synack_retries: 2
  net.ipv4.tcp_syncookies: 1
  net.ipv4.tcp_timestamps: 0
  net.ipv6.conf.all.accept_ra: 0
  net.ipv6.conf.all.accept_redirects: 0
  net.ipv6.conf.all.accept_source_route: 0
  net.ipv6.conf.all.forwarding: 0
  net.ipv6.conf.all.use_tempaddr: 2
  net.ipv6.conf.default.accept_ra: 0
  net.ipv6.conf.default.accept_ra_defrtr: 0
  net.ipv6.conf.default.accept_ra_pinfo: 0
  net.ipv6.conf.default.accept_ra_rtr_pref: 0
  net.ipv6.conf.default.accept_redirects: 0
  net.ipv6.conf.default.accept_source_route: 0
  net.ipv6.conf.default.autoconf: 0
  net.ipv6.conf.default.dad_transmits: 0
  net.ipv6.conf.default.max_addresses: 1
  net.ipv6.conf.default.router_solicitations: 0
  net.ipv6.conf.default.use_tempaddr: 2
  net.netfilter.nf_conntrack_max: 2000000
  net.netfilter.nf_conntrack_tcp_loose: 0
```

### ./defaults/main/users.yml

```yaml
delete_users:
  - games
  - gnats
  - irc
  - list
  - news
  - sync
  - uucp
```

## Recommended Reading

[Comparing the DISA STIG and CIS Benchmark values](https://github.com/konstruktoid/publications/blob/master/ubuntu_comparing_guides_benchmarks.md)

[Center for Internet Security Linux Benchmarks](https://www.cisecurity.org/cis-benchmarks/)

[Common Configuration Enumeration](https://nvd.nist.gov/cce/index.cfm)

[DISA Security Technical Implementation Guides](https://public.cyber.mil/stigs/downloads/?_dl_facet_stigs=operating-systems%2Cunix-linux)

[SCAP Security Guides](https://static.open-scap.org/)

[Security focused systemd configuration](https://github.com/konstruktoid/hardening/blob/master/systemd.adoc)

## Contributing

Do you want to contribute? Great! Contributions are always welcome,
no matter how large or small. If you found something odd, feel free to submit a
issue, improve the code by creating a pull request, or by
[sponsoring this project](https://github.com/sponsors/konstruktoid).

## License

Apache License Version 2.0

## Author Information

[https://github.com/konstruktoid](https://github.com/konstruktoid "github.com/konstruktoid")
