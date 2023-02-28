output "gke_node_pools_instance_group_urls" {
  value = google_container_cluster.primary.node_pool[0].managed_instance_group_urls
}
