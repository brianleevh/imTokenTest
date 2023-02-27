variable "prefix_name" {
  type        = string
  description = "Resource Prefix Name"
}

variable "region" {
  type        = string
  description = "Resource GCP Region"
}

variable "public_subnet_cidr_a" {
  type        = string
  description = "Public Subnet A CIDR Range"
}

variable "public_subnet_cidr_b" {
  type        = string
  description = "Public Subnet B CIDR Range"
}

variable "private_subnet_cidr_a" {
  type        = string
  description = "Private Subnet A CIDR Range"
}

variable "private_subnet_cidr_b" {
  type        = string
  description = "Private Subnet B CIDR Range"
}
