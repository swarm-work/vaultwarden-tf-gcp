locals {
  custom_email_id_exists = var.service_account_email != "" ? 1 : 0
}

resource "google_compute_disk" "vaultwarden" {
  name  = var.name
  type  = var.disk_type
  size  = var.disk_size
  zone  = var.zone
  image = var.disk_image
}

resource "google_compute_instance" "vaultwarden" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = var.instance_stop_on_update
  desired_status            = var.instance_desired_status
  deletion_protection       = var.instance_deletion_protection
  tags                      = var.instance_tags

  boot_disk {
    device_name = var.name
    auto_delete = var.instance_auto_delete_disk
    source      = google_compute_disk.vaultwarden.self_link
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

  service_account {
    email  = var.service_account_email != "" ? google_service_account.vaultwarden[0].email : ""
    scopes = var.service_account_scopes
  }
}

resource "google_compute_resource_policy" "daily_backup" {
  name   = var.name
  region = var.region
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.snapshot_cycle
        start_time    = var.snapshot_daily_schedule
      }
    }
    retention_policy {
      max_retention_days    = var.snapshot_retention_days
      on_source_disk_delete = var.snapshot_on_disk_delete
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "attachment" {
  name = google_compute_resource_policy.daily_backup.name
  disk = google_compute_disk.vaultwarden.name
  zone = var.zone
}

resource "google_service_account" "vaultwarden" {
  count        = local.custom_email_id_exists
  account_id   = var.service_account_email
  display_name = var.service_account_email
}

resource "google_project_iam_binding" "vaultwarden" {
  count   = local.custom_email_id_exists
  project = var.project_id
  role    = var.iam_role
  members = ["serviceAccount:${google_service_account.vaultwarden[0].email}"]
}
