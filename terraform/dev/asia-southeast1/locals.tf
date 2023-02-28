locals {
  gcp_project  = "artful-athlete-379106"
  environment  = "dev"
  region       = "asia-southeast1"
  region_abrv  = "sea1"
  zone_1       = "asia-southeast1-a"
  zone_2       = "asia-southeast1-b"
  zone_3       = "asia-southeast1-c"
  zone_4       = "asia-southeast1-d"
  project_name = "imtoken"
  prefix       = "${local.project_name}-${local.environment}-${local.region_abrv}"
}
