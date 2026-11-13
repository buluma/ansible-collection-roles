# Updating the roles

1. Delete the roles:

```shell
rm -Rf roles/*
```

2. Copy the roles in:

```shell
./UPDATING.sh
```

3. Update galaxy.yml

Bump version. Make sure every collection in `requirements.yml` is listed under `dependencies`, with a lower bound on the version the roles were tested against. CI fails when one is missing.

4. Release

Commit, then publish a GitHub release whose tag matches the galaxy.yml version (for example `3.0.0`). Publishing the release deploys the collection to Galaxy.
