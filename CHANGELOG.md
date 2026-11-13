# Changelog

## 3.0.0 (unreleased)

**Breaking changes:**

- Requires ansible-core 2.19 or newer.
- Removed roles whose source repositories are archived or deleted: artifactory, atom, bios_update, blender, borgbackup, brightbox_ruby, bugzilla, buildah, cassandra, checkmk_agent, cloud_init, cobbler, containers_common, cve_2021_44228, desktop, digitalocean, docker_arm, docker_services, dryrun, eclipse, ecr_container_build, envoy, foreman.
- Roles with hyphens in their source name now use underscores: `digitalocean_agent`, `lemp_stack`, `netiq_sentinel_syslog_event_source`, `redmine_1`.
- Roles depending on other buluma roles now use the copies inside this collection (`buluma.roles.<role>`) instead of standalone Galaxy roles.

**Changes:**

- Synced all roles from their source repositories (236 roles, up from 73).
- Declared all required collections in galaxy.yml with minimum versions.
- Collection is published to Galaxy only when a GitHub release is published.
