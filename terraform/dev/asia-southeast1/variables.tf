variable "public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR Range"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private Subnet CIDR Range"
}

variable "root_sshkey" {
  type        = string
  description = "Compute Instance Root SSH Public Key"
}

variable "whitelisted_ip_list" {
  type        = list(string)
  description = "Whitelisetd IP List to the Network"
}

variable "gke_master_ipv4_cidr_block" {
  type = string
}

variable "gke_cluster_ipv4_cidr_block" {
  type = string
}

variable "gke_services_ipv4_cidr_block" {
  type = string
}