#!/bin/sh
# Remove outdated containers and prune old networks/images/containers

while true
do
  for i in $(docker ps | awk '{print $2}' | grep -v : )
  do
    for j in $(docker ps | grep $i | awk '{print $1}' | grep -v CONTAINER )
    do
      docker rm -f $j
    done
  done

  # Clean up registry
  REGISTRY="$(docker ps | grep registry: | awk '{print $1}')"
  if [ -n "$REGISTRY" ]
  then
    docker exec $(docker ps | grep registry: | awk '{print $1}') /bin/registry garbage-collect -m /etc/docker/registry/config.yml
  fi

  docker system prune -af --volumes
  sleep 3600
done
