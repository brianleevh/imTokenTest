variable "prefix_name" {
  type        = string
  description = "Resource Prefix Name"
}

variable "region" {
  type        = string
  description = "Resource GCP Region"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR Range"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private Subnet CIDR Range"
}

variable "whitelisted_ip_list" {
  type = list(string)
  description = "Whitelisetd IP List to the Network"
}