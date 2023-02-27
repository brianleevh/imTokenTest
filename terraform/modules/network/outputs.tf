output "public_subnet_id" {
  value = google_compute_subnetwork.pub_subnet.id
  description = "Public Subnet ID"
}

output "private_subnet_id" {
  value = google_compute_subnetwork.priv_subnet.id
  description = "Private Subnet ID"
}

output "network_self_link" {
  value = google_compute_network.vpc_network.self_link
  description = "VPC Network Self_link"
}

output "public_subnet_self_link" {
  value = google_compute_subnetwork.pub_subnet.self_link
  description = "Public Subnetwork Self_link"
}

output "private_subnet_self_link" {
  value = google_compute_subnetwork.priv_subnet.self_link
  description = "Private Subnetwork Self_link"
}
