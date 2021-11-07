terraform {
  backend "gcs" {
    bucket = "vaultwarden-tf-state"
    prefix = "dev"
  }
}
