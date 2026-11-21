# Changelog

## 4.1.0 (2026-11-21)

**Breaking changes:**

- `vault_configuration`: no default TLS certificate and private key any more. Every `tcp` listener without `tls_disable: true` must set `tls_cert` or `tls_cert_file`, and `tls_key` or `tls_key_file`, otherwise the role fails and names the listener. The old default key was public, so rotate it if you ran the role with it.
- `fish`: the default release is now 4. The release 4 repository has no EL builds, so on EL hosts the role fails early with a message. Set `fish_release_version: 3` there. Release 3 on EL 9 now works (Rocky and AlmaLinux are mapped), release 3 on EL 10 and on Fedora 42 and later stops with a message.
- `nodejs`: the default is now Node.js 26.x (was 20.x, end of life). Versions 22.x and later use NodeSource's `nodistro` RPM repository on EL, 18.x to 20.x keep the release rpm. Pin `nodejs_version` to keep your major.
- `datadog`: re-vendored from upstream 4.21.0 to 5.6.0. Python 2, Agent 5, Ansible older than 2.10 and older Amazon Linux 2 and CentOS are no longer supported. Variables removed: `datadog_inject_apm_flavor`, `datadog_ignore_old_centos_python3_error`, `datadog_apm_instrumentation_languages`, the Docker APM injection variables and `datadog_agent5_*_repo`. Added: `datadog_apm_instrumentation_libraries`, `datadog_installer_*`, `datadog_windows_skip_install`, `datadog_windows_force_reinstall` and new GPG key variables. See the role README for the full list.

**Changes:**

- `datadog`: the copy in 4.0.0 still had `win_ansible.builtin.shell`, a module name that does not exist, in its Windows tasks. Hosts running those tasks failed with "couldn't resolve module/action". It also has two local hardenings: `no_log` on the single step instrumentation tasks when `datadog_installer_auth` is set, and a Windows remote-update check that only trusts a Datadog-signed `datadog-installer.exe` under Program Files\Datadog (switch off with `datadog_remote_update_verify_installer: false`). Not yet tested on a Windows host.
- `solr`: Solr 10 is supported with `solr_version: "10.1.0"` and Java 21 or newer installed first. It is started in standalone (user-managed) mode through a systemd drop-in and its cores are created with `--solr-url`. The default stays 9.11.0. The major version was compared as a string, so `'10' >= '5'` was false, that is fixed. The Nashorn jar is 15.7.
- `tomcat`: instances accept Tomcat 10.1 and 11 (11.0.29) and download their own major version (before, every instance downloaded the global `tomcat_version`). The default stays 9 (9.0.124), 10.1 is 10.1.62. Java needed: 9 runs on 8 and newer, 10.1 on 11 and newer, 11 on 17 and newer.
- `openjdk` and `crun`: the opensuse alvistack and Adoptium apt keys are fetched over https and installed only if their fingerprint is the listed id. `bamboo`: opensuse URLs use https.
- `bareos_fd` and `users`: the test keys are generated for every run instead of being committed. The role code is unchanged.
- Updated pinned versions: docker_compose 5.8.0, firefox 160.0.1, gitea 28.4.0, gitlab 19.6.1, kubernetes 1.37, netdata 2.13.0, sonarqube 26.11.0.134175, vector 0.62.0 (the deb now comes from GitHub releases), victoriametrics 1.156.0 and irslackd 0ccfdc3.
- CI: the collection tests now also run on ansible-core 2.19, the declared minimum, and check that every module the roles call resolves, including those in files loaded with `include_tasks`, which `--syntax-check` skips.
- Synced from the merged state of the source repositories, not from local checkouts. `redmine_1` is unchanged.

## 4.0.0 (2026-11-20)

**Breaking changes:**

- `apt_repository`: items in `apt_repositories` now use `name`, `uris`, `suites`, `components`, `types`, `architectures`, `signed_by` and `state`. The old `repo` and `validate_certs` keys are no longer supported, and the role fails with a message that says how to convert. A PPA is now a normal repository with its URI and an explicit key. Remove the old one-line source files by hand before upgrading, otherwise a repository is listed twice.
- `bitbucket`: `bitbucket.properties` is now written with mode 0600 instead of 0644, which is the mode Bitbucket applies to it.

**Changes:**

- Replaced `ansible.builtin.apt_repository`, deprecated in ansible-core and removed in 2.25, with `ansible.builtin.deb822_repository` in 27 roles: apt_repository, azure_cli, bareos_repository, beats, bitbucket, code, crun, datadog, docker_ce, elastic_repo, enpass, firefox, fish, gitlab, hashicorp, influxdb2, jenkins, jitsi, kubernetes, mssql, nodejs, npm, openjdk, perforce, sensu, varnish and virtualbox. They install `python3-debian` on Debian and Ubuntu targets, remove the sources and keys that earlier versions wrote, and refresh the apt cache when a repository changes.
- Set `min_ansible_version` to 2.19 in every role, matching the collection, except `redmine_1`, whose source repository is archived.
- Updated pinned versions: terraform 1.17.2, vault 2.2.2, telegraf 1.40.3, go 1.27.4, maven 3.10.1, drush 13.8.1, cfssl 1.7.2, daemonize 1.7.8, tree-sitter 0.27.2, etherpad 3.3.20, kernel 6.12.118, ruby 4.0.10 and ocis 8.2.3.
- Replaced injected fact variables with `ansible_facts[...]` in virtualbox and python_pip, and silenced a harmless ansible-lint warning on the templated `types` value in the migrated roles.
- Synced all roles from their source repositories again (236 roles).

## 3.0.0 (2026-11-13)

**Breaking changes:**

- Requires ansible-core 2.19 or newer.
- Removed roles whose source repositories are archived or deleted: artifactory, atom, bios_update, blender, borgbackup, brightbox_ruby, bugzilla, buildah, cassandra, checkmk_agent, cloud_init, cobbler, containers_common, cve_2021_44228, desktop, digitalocean, docker_arm, docker_services, dryrun, eclipse, ecr_container_build, envoy, foreman.
- Roles with hyphens in their source name now use underscores: `digitalocean_agent`, `lemp_stack`, `netiq_sentinel_syslog_event_source`, `redmine_1`.
- Roles depending on other buluma roles now use the copies inside this collection (`buluma.roles.<role>`) instead of standalone Galaxy roles.

**Changes:**

- Synced all roles from their source repositories (236 roles, up from 73).
- Declared all required collections in galaxy.yml with minimum versions.
- Collection is published to Galaxy only when a GitHub release is published.
