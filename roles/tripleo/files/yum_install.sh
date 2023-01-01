#!/bin/bash

set -eou pipefail

PKG="$(command -v dnf || command -v yum)"
PKG_MGR="$(echo ${PKG:(-3)})"

if [ -z "$1" ]; then
    echo "No packages were specified to install..."
    exit 1
fi

YUM_PACKAGES=$1

$PKG -y install $YUM_PACKAGES
rm -rf /var/cache/$PKG_MGR
