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
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "network_self_link" {
  type = string
  description = "Network self_link"
}
variable "subnetwork_self_link" {
  type = string
  description = "Subnetwork self_link"
}