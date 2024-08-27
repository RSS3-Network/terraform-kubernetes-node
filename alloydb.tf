module "alloy-db" {
  source           = "GoogleCloudPlatform/alloy-db/google"
  version          = "~> 3.0"
  project_id       = var.google_project_id
  cluster_id       = "alloydb-cluster-rss3"
  cluster_location = "us-central1"
  cluster_initial_user = {
    user     = "rss3",
    password = random_password.alloy_password.result
  }
  network_self_link = "projects/${var.google_project_id}/global/networks/${var.google_vpc_network_name}"
  primary_instance = {
    instance_id       = "primary-instance",
    instance_type     = "PRIMARY",
    machine_cpu_count = 2,
    database_flags    = {},
    display_name      = "alloydb-primary-instance"
  }
}

locals {
  database_uri = "postgresql://rss3:${random_password.alloy_password.result}@${module.alloy-db.primary_psc_dns_name}:5432/postgres"
}
