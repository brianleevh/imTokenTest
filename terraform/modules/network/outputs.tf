output "public_subnet_id" {
  value = google_compute_subnetwork.pub_subnet.id
  description = "Public Subnet ID"
}

output "private_subnet_id" {
  value = google_compute_subnetwork.priv_subnet.id
  description = "Private Subnet ID"
}