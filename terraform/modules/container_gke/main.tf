resource "google_container_cluster" "primary" {
  name     = "${var.prefix_name}-${var.name}"
  location = var.region
  network            = var.network_self_link
  subnetwork         = var.subnetwork_self_link

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.prefix_name}-${var.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
  network_config {
    enable_private_nodes = true
  }
  node_config {
    preemptible  = true
    machine_type = var.machine_type

    service_account = var.svc_account_email
    oauth_scopes    = var.svc_account_scopes

    tags = ["${var.environment}", "${var.region}", "${var.tag}"]
  }
}