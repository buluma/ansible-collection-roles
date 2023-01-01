#!/bin/sh

set -eox pipefail

rpm --replacepkgs --replacefiles --oldpackage -Uvh /tmp/*.rpm
rm -f /tmp/*.rpm
rm -f /tmp/rpm_install.sh
