#!/bin/sh

# Copy all roles.
for role in ../ansible-role-* ; do
  # Collection role names must be [a-z0-9_], so map hyphens to underscores.
  short=$(basename ${role} | sed 's/^ansible-role-//; s/-/_/g')
  if [ ! -d roles/${short} ] ; then
    mkdir "roles/${short}"
    echo "Copying ${role} to roles/${short}."
    for object in LICENSE README.md defaults files handlers meta requirements.yml tasks templates vars ; do
      if [ -d "${role}/${object}" ] ; then
        cp -Rip "${role}/${object}" "roles/${short}/${object}"
      elif [ -f "${role}/${object}" ] ; then
        cp "${role}/${object}" "roles/${short}/${object}"
      fi
    done
    # Point buluma.<role> references at the copies inside this collection.
    find "roles/${short}/meta" "roles/${short}/tasks" -name '*.yml' -exec \
      sed -i.bak -E 's/((role|name): )buluma\.([a-z0-9_]+)$/\1buluma.roles.\3/' {} +
    find "roles/${short}" -name '*.yml.bak' -delete
  fi
done

# Regenerate all used collections (only the collections: section, not roles:).
echo "---" > requirements.yml
echo "collections:" >> requirements.yml
cat roles/*/requirements.yml | awk '/^[a-z]/ { c = ($0 ~ /^collections:/) } c && /^  - name: /' | grep -v buluma | sort | uniq >> requirements.yml
