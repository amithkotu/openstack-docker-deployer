#!/bin/sh
set -e

# Pass the command provided by the user to kolla-ansible
exec kolla-ansible "$@" -i /etc/kolla/inventory/hosts  -l all:\!localhost