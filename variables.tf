#############################
# Global
#############################

variable "project_id" {
  description = "Name of the GCP project"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where resources will be created"
  type        = string
  default     = "us-central1-a"
}

variable "name" {
  description = "Name to use on all resources created (Instance, Disk, etc)"
  type        = string

}

#############################
# Compute Instance variables
#############################

variable "machine_type" {
  description = "Machine type to be use when provisioning the instance"
  type        = string
  default     = "e2-micro"
}

variable "instance_stop_on_update" {
  description = "Allows Terraform to stop the instance for updating properties"
  type        = bool
  default     = true
}

variable "instance_desired_status" {
  description = "The desired status of the isntance"
  type        = string
  default     = "RUNNING"
}

variable "instance_deletion_protection" {
  description = "Enables deletion protection. In order to remove the resource, disable protection by setting the value to false"
  type        = bool
  default     = true
}

variable "instance_tags" {
  description = "List of network tags to attach to the instance"
  type        = list(string)
  default     = []
}

variable "instance_auto_delete_disk" {
  description = "Specifies whether to delete the boot disk after deleting the instance"
  type        = bool
  default     = false
}


#############################
# Disk variables
#############################

variable "disk_type" {
  description = "Describes the disk type to use when creating the disk"
  type        = string
  default     = "pd-standard"
}

variable "disk_size" {
  description = "Size of the disk"
  type        = number
  default     = 10
}

variable "disk_image" {
  description = "System image of the disk"
  type        = string
  default     = "debian-cloud/debian-9"
}


#############################
# Snapshot variables
#############################

variable "snapshot_cycle" {
  description = "Number of snapshot cycles"
  type        = number
  default     = 1
}

variable "snapshot_daily_schedule" {
  description = "Daily schedule when to start creating a disk snapshot"
  type        = string
  default     = "00:00"
}

variable "snapshot_retention_days" {
  description = "Number of days to keep snapshots"
  type        = number
  default     = 7
}

variable "snapshot_on_disk_delete" {
  description = "Behavior when source disk is deleted. Valid values are: KEEP_AUTO_SNAPSHOTS and APPLY_RETENTION_POLICY"
  type        = string
  default     = "KEEP_AUTO_SNAPSHOTS"
}


#############################
# Service Account variables
#############################

variable "service_account_email" {
  description = "Service account id"
  type        = string
  default     = ""
}

variable "service_account_scopes" {
  description = "A list of service scopes"
  type        = list(string)
  default     = ["cloud-platform"]
}


#############################
# IAM Binding variables
#############################

variable "iam_role" {
  description = "The role binded to a service account"
  type        = string
  default     = "roles/editor"
}
