# Changelog

## Unreleased

**Changes:**

- `datadog`: synced from the merged 5.6.0 re-vendor. The copy in 4.0.0 still had `win_ansible.builtin.shell`, a module name that does not exist, in its Windows tasks. Hosts running those tasks failed with "couldn't resolve module/action".
- CI: the collection tests now also run on ansible-core 2.19, the declared minimum, and check that every module the roles call resolves, including those in files loaded with `include_tasks`, which `--syntax-check` skips.

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
