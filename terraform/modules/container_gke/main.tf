resource "google_container_cluster" "primary" {
  name       = "${var.prefix_name}-${var.name}-cluster"
  location   = var.region
  network    = var.network_self_link
  subnetwork = var.subnetwork_self_link

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.bastion_ip}/32"
      display_name = "External Control Plane access"
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.prefix_name}-${var.name}-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  autoscaling {
    min_node_count = "1"
    max_node_count = "3"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_size_gb = 50

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.svc_account_email
    oauth_scopes    = var.svc_account_scopes
  }
}
