module "node" {
  depends_on = [
    module.alloy-db,
    module.memorystore
  ]
  source = "../.."

  database_uri = local.database_uri

  node_workers       = var.node_workers
  node_rpc_endpoints = var.node_rpc_endpoints

  node_register        = true
  node_register_config = var.node_register_config
}
