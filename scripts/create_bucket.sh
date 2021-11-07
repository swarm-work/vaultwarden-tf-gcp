#!/usr/bin/env bash
set -e -u

script_dir="$(dirname "$0")"

location="us-central1"
storage_class="nearline"
bucket_name="vaultwarden-tf-state"

gsutil mb -c "${storage_class}" -l "${location}" gs://"${bucket_name}"

gsutil versioning set on gs://"${bucket_name}"

gsutil lifecycle set "${script_dir}"/lifecycle.json gs://"${bucket_name}"
