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
      discovery = var.node_register_config
    }
  }
}

resource "helm_release" "node" {
  depends_on = [helm_release.cockroachdb]
  name       = "node"
  namespace  = var.namespace
  repository = "https://rss3-network.github.io/helm-charts"
  chart      = "node"
  version    = "0.4.0"

  values = concat([
    yamlencode(local.node_values)
  ], var.node_values)
}
