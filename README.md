# vaultwarden-tf-gcp

Deploy [vaultwarden](https://github.com/dani-garcia/vaultwarden) (formerly known as bitwarden_rs) to GCP using [Terraform](https://github.com/hashicorp/terraform)


## Prerequisite
- GCP Account with Compute Instance Admin role or higher and Cloud Storage Admin role
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?_ga=2.198109615.186428419.1636178922-1995455692.1634648083) installed

## Usage

1. Clone this github repository:

```
$ git clone git@github.com:swarm-work/vaultwarden-tf-gcp.git
```

2. Create a backend storage bucket:

```
$ cd vaultwarden-tf-gcp
$ ./scripts/create_bucket.sh
```

Alternatively, create the [storage bucket](https://cloud.google.com/storage/docs/using-object-versioning#console) in the Google Cloud Console.

3. Create the server instance:

```
$ cd vaultwarden-tf-gcp
$ terraform apply
```
4. Setup the environment and install vaultwarden:

```
$ ./scripts/setup_vaultwarden.sh
```
Set all environment variables in `vaultwarden/.env`. See complete list of vaultwarden's environment variables [here](https://github.com/dani-garcia/vaultwarden/blob/main/.env.template).

## Provide Compute Instance configuration values

Set all values in `terraform.tfvars`.

```hcl
# Global

project_id = "your-project-id"
name       = "vaultwarden-server-dev"

# Compute Instance

instance_tags = ["http-server", "https-server"]

# Snapshot

snapshot_daily_schedule = "04:00"
```

See the sample values of all variables in `terraform.tfvars.sample-full`.

## Notes

1. The provisioned server will have the minimum functionality needed. 
1. Add resources (e.g. google_compute_attached_disk) as you see fit.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.10 |
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | >= 4.0.0 |

## Authors

This repository is maintained by [Swarm](https://github.com/swarm-work).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/swarm-work/vaultwarden-tf-gcp/tree/master/LICENSE) for full details.
