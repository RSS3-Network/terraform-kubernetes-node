locals {
  node_values = {
    core = {
      replicaCount = var.node_replicas
    }
    database = {
      uri = local.database_uri
    }
    redis = {
      enable        = var.redis_enable
      endpoints     = [var.redis_enable ? var.redis_endpoint : null]
      username      = var.redis_enable ? var.redis_username : null
      password      = var.redis_enable ? var.redis_password : null
      disable_cache = true
      tls = {
        enabled = false
      }
    }
    endpoints = var.node_rpc_endpoints
    workers   = var.node_workers

    broadcaster = {
      enabled = var.node_register
    }
    configs = {
      discovery = {
        maintainer = {
          evm_address = var.node_register_evm_address
          signature   = var.node_register_evm_signature
        }
        server = {
          endpoint                = var.node_http_endpoint
          global_indexer_endpoint = var.node_register_gi_address

        }
      }
    }
  }
}

resource "helm_release" "node" {
  depends_on = [helm_release.cockroachdb]
  name       = "node"
  namespace  = var.namespace
  repository = "https://rss3-network.github.io/helm-charts"
  chart      = "node"
  version    = "0.3.15"

  values = concat([
    yamlencode(local.node_values)
  ], var.node_values)
}
