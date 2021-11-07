#!/usr/bin/env bash

# Usage:
#  ./scripts/setup_vaultwarden.sh

set -e -u

script_dir="$(dirname "$0")"
instance_name="vaultwarden-server"

gcloud compute scp "${script_dir}"/_setup_environment.sh "${instance_name}":/tmp
gcloud compute scp --recurse vaultwarden "${instance_name}":/tmp
gcloud compute ssh "${instance_name}" --command="sudo bash /tmp/_setup_environment.sh | tee logs"
