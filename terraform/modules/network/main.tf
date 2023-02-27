resource "google_compute_network" "vpc_network" {
  name                            = "${var.prefix_name}-vpc"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  mtu                             = 1460
}

resource "google_compute_subnetwork" "pub_subnet" {
  name          = "${var.prefix_name}-pub-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.public_subnet_cidr
}

resource "google_compute_subnetwork" "priv_subnet" {
  name          = "${var.prefix_name}-priv-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.private_subnet_cidr
}

resource "google_compute_router" "router" {
  name          = "${var.prefix_name}-router"
  network = google_compute_network.vpc_network.name
  
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "1.2.3.4"
    }
    advertised_ip_ranges {
      range = "6.7.0.0/16"
    }
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.prefix_name}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.priv_subnet.id
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
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "all"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "${var.public_subnet_cidr}",
    "${var.private_subnet_cidr}"
  ]
}