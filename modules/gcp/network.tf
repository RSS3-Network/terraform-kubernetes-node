locals {
  network_name = "dsl-gke-network"
  subnet_name  = "dsl-gke-subnet"

  ip-range-pods-name     = "ip-range-pods"
  ip-range-services-name = "ip-range-services"
}

module "gcp-network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  project_id   = var.project_id
  network_name = local.network_name

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = var.subnet_ip
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    "${local.subnet_name}" = [
      {
        range_name    = local.ip-range-pods-name
        ip_cidr_range = var.pod_ip_range
      },
      {
        range_name    = local.ip-range-services-name
        ip_cidr_range = var.service_ip_range
      }
    ]
  }
}
