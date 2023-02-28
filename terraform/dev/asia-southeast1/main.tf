module "network" {
  source = "../../modules/network"

  prefix_name         = local.prefix
  region              = local.region
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  whitelisted_ip_list = var.whitelisted_ip_list
}

resource "google_service_account" "compute_engine_svc" {
  account_id   = "${local.prefix}-compute-svc"
  display_name = "Compute Instance Service Account"
}

module "bastion" {
  source = "../../modules/compute_vm"

  prefix_name       = local.prefix
  name              = "bastion"
  environment       = local.environment
  region            = local.region
  region_zone       = local.zone_1
  subnet_id         = module.network.public_subnet_id
  root_sshkey       = var.root_sshkey
  tag               = "bastion"
  public_access     = true
  svc_account_email = google_service_account.compute_engine_svc.email
}

module "jumphost" {
  source = "../../modules/compute_vm"

  prefix_name       = local.prefix
  name              = "jumphost"
  environment       = local.environment
  region            = local.region
  region_zone       = local.zone_1
  subnet_id         = module.network.public_subnet_id
  root_sshkey       = var.root_sshkey
  tag               = "jumphost"
  boot_disk_size    = 50
  data_disk_size    = 50
  public_access     = true
  svc_account_email = google_service_account.compute_engine_svc.email
}

module "gke" {
  source = "../../modules/container_gke"

  prefix_name              = local.prefix
  name                     = "gke"
  environment              = local.environment
  region                   = local.region
  tag                      = "gke"
  network_self_link        = module.network.network_self_link
  subnetwork_self_link     = module.network.private_subnet_self_link
  svc_account_email        = google_service_account.compute_engine_svc.email
  master_ipv4_cidr_block   = var.gke_master_ipv4_cidr_block
  cluster_ipv4_cidr_block  = var.gke_cluster_ipv4_cidr_block
  services_ipv4_cidr_block = var.gke_services_ipv4_cidr_block
  network_cidr             = var.private_subnet_cidr
  bastion_ip               = module.bastion.priv_ip
}

# module "lb" {
#   source = "../../modules/lb_forwarding_rule"

#   prefix_name       = local.prefix
#   name              = "lb"
#   environment       = local.environment
#   region            = local.region
#   tag               = "lb"
#   backend_group     = module.gke.gke_node_pools_instance_group_urls[0]
#   # google_container_cluster.my_cluster.node_pools.0.instance_group_urls[0]
# }