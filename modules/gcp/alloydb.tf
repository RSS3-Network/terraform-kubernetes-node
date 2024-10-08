module "alloy-db" {
  source           = "GoogleCloudPlatform/alloy-db/google"
  version          = "~> 3.0"

depends_on = [ 
  module.gcp-network
 ]

  project_id       = var.project_id
  cluster_id       = "alloydb-dsl"
  cluster_location = var.region
  cluster_initial_user = {
    user     = local.database_user,
    password = random_password.alloy_password.result
  }
  network_self_link = google_service_networking_connection.alloydb.network

  primary_instance = {
    instance_id       = "primary-instance",
    instance_type     = "PRIMARY",
    machine_cpu_count = var.alloydb_cpu_count,
    database_flags    = {},
    display_name      = "alloydb-primary-instance"
  }
}

// compatible with shells consider using only uppercase and lowercase letters
resource "random_password" "alloy_password" {
  length      = 16
  special     = false
  min_lower   = 4
  min_upper   = 4
  min_numeric = 4
}

locals {
  database_user = "node"
  database_uri  = "postgresql://${local.database_user}:${random_password.alloy_password.result}@${module.alloy-db.primary_instance.ip_address}:5432/postgres"
}
