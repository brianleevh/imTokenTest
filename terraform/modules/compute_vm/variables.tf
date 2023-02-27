variable "prefix_name" {
  type        = string
  description = "Resource Prefix Name"
}

variable "name" {
  type        = string
  description = "Resource Name"
}

variable "machine_type" {
  type = string
  description = "Compute Machine Type"
  default = "e2-standard-4"
}

variable "environment" {
  type = string
  description = "Resource Environment"
}

variable "region" {
  type = string
  description = "Compute Instance Region"
}

variable "region_zone" {
  type = string
  description = "Compute Instance Region Zone"
}

variable "subnet_id" {
  type = string
  description = "Compute Instance Subnetwork ID"
}

variable "root_sshkey" {
  type = string
  description = "Compute Instance Root SSH Public Key"
}

variable "tag" {
  type = string
  description = "Tag for the Resource"
}

variable "svc_account_email" {
  type = string
  description = "GCP Service Account Email"
}

variable "svc_account_scopes" {
  type = list(string)
  description = "GCP Service Account Scopes"
  default = ["cloud-platform"]
}

variable "boot_disk_type" {
  type = string
  description = "Boot Disk Type"
  default = "pd-balanced"
}

variable "boot_disk_size" {
  type = number
  description = "Boot Disk Size (GB)"
  default = "100"
}

variable "data_disk_type" {
  type = string
  description = "Data Disk Type"
  default = "pd-balanced"
}

variable "data_disk_size" {
  type = number
  description = "Data Disk Size (GB)"
  default = "100"
}

variable "public_access" {
  type = bool
  description = "Compute Instance require Public Access?"
  default = false
}