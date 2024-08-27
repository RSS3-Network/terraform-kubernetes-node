data "google_client_config" "default" {}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version = "~> 31.0"

  project_id = var.project_id
  name       = var.cluster_name
  region     = var.region
  zones      = var.zones
  regional   = var.regional

  network           = module.gcp-network.network_name
  subnetwork        = local.subnet_name
  ip_range_pods     = local.ip-range-pods-name
  ip_range_services = local.ip-range-services-name

  horizontal_pod_autoscaling = true
  http_load_balancing        = true
  create_service_account     = true

  dns_cache = false
  depends_on = [ module.gcp-network ]
}
