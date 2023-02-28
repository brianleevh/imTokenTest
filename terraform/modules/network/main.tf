resource "google_compute_network" "vpc_network" {
  name                            = "${var.prefix_name}-vpc"
  auto_create_subnetworks         = false
  mtu                             = 1460
}

resource "google_compute_subnetwork" "pub_subnet" {
  name          = "${var.prefix_name}-pub-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = var.public_subnet_cidr
}

resource "google_compute_subnetwork" "priv_subnet" {
  name          = "${var.prefix_name}-priv-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = var.private_subnet_cidr
}

resource "google_compute_router" "router" {
  name          = "${var.prefix_name}-router"
  network = google_compute_network.vpc_network.self_link
  
  bgp {
    asn               = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.prefix_name}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.priv_subnet.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  depends_on = [google_compute_subnetwork.priv_subnet]
}

resource "google_compute_firewall" "internal_network" {
  name    = "${var.prefix_name}-internal-firewall"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "${var.public_subnet_cidr}",
    "${var.private_subnet_cidr}"
  ]
}

resource "google_compute_firewall" "common_rules" {
  name    = "${var.prefix_name}-common-rules"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = [22, 80, 443]
  }

  source_ranges = var.whitelisted_ip_list
}
