module "memorystore" {
  count = var.redis_enable ? 1 : 0

  source  = "terraform-google-modules/memorystore/google"
  version = "~> 10.0"

  name           = "node-memorystore"
  project        = var.project_id
  memory_size_gb = "1"
  enable_apis    = "true"
  auth_enabled   = true
  region = var.region

  authorized_network = module.gcp-network.network_name
}
