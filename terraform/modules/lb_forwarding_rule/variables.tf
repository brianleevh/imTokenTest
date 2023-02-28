variable "prefix_name" {
  type        = string
  description = "Resource Prefix Name"
}

variable "name" {
  type        = string
  description = "Resource Name"
}

variable "environment" {
  type        = string
  description = "Resource Environment"
}

variable "region" {
  type        = string
  description = "Compute Instance Region"
}

# variable "region_zone" {
#   type = string
#   description = "Compute Instance Region Zone"
# }

variable "backend_group" {
  type        = string
  description = "Forwarding Rule Backend Group"
}

variable "tag" {
  type        = string
  description = "Tag for the Resource"
}