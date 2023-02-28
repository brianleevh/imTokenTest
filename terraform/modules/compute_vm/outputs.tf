output "priv_ip" {
  value       = google_compute_instance.compute_vm.network_interface.0.network_ip
  description = "The Private IP address of the instance."
}