locals {
  ethereum_worker = [
    {
      network  = "ethereum"
      worker   = "rss3"
      id       = "ethereum-rss3"
      endpoint = "ethereum"
    },
    {
      network  = "ethereum"
      worker   = "opensea"
      id       = "ethereum-opensea"
      endpoint = "ethereum"
      resources = {
        limits = {
          cpu    = "500m"
          memory = "1Gi"
        }
        requests = {
          cpu    = "200m"
          memory = "512Mi"
        }
      }
    },
    {
      network  = "ethereum"
      worker   = "uniswap"
      id       = "ethereum-uniswap"
      endpoint = "ethereum"
      resources = {
        limits = {
          cpu    = "2"
          memory = "2Gi"
        }
        requests = {
          cpu    = "1"
          memory = "1Gi"
        }
      }
    },
    {
      network  = "ethereum"
      worker   = "optimism"
      id       = "ethereum-optimism"
      endpoint = "ethereum"
    },
    {
      network  = "ethereum"
      worker   = "core"
      id       = "ethereum-core"
      endpoint = "ethereum"
      resources = {
        limits = {
          cpu    = "4"
          memory = "4Gi"
        }
        requests = {
          cpu    = "2"
          memory = "2Gi"
        }
      }
    },
    {
      network  = "ethereum"
      worker   = "highlight"
      id       = "ethereum-highlight"
      endpoint = "ethereum"
      resources = {
        limits = {
          cpu    = "1"
          memory = "1Gi"
        }
        requests = {
          cpu    = "500m"
          memory = "512Mi"
        }
      }
    },
    {
      network  = "ethereum"
      worker   = "looksrare"
      id       = "ethereum-looksrare"
      endpoint = "ethereum"
    },
    {
      network  = "ethereum"
      worker   = "lido"
      id       = "ethereum-lido"
      endpoint = "ethereum"
    },
    {
      network  = "ethereum"
      worker   = "aave"
      id       = "ethereum-aave"
      endpoint = "ethereum"
    },
    {
      network  = "ethereum"
      worker   = "1inch"
      id       = "ethereum-1inch"
      endpoint = "ethereum"
    }
  ]
  internal_worker = [
    {
      id       = "arweave-mirror"
      network  = "arweave"
      worker   = "mirror"
      endpoint = "https://arweave.net"

      resources = {
        requests = {
          cpu    = "500m"
          memory = "512Mi"
        }
        limits = {
          cpu    = "1"
          memory = "1Gi"
        }
      }
    },
    {
      id       = "arweave-paragraph"
      network  = "arweave"
      worker   = "paragraph"
      endpoint = "https://arweave.net"
    },
    {
      id       = "crossbell",
      worker   = "crossbell",
      network  = "crossbell",
      endpoint = "https://rpc.crossbell.io"
    },
    {
      id       = "vsl-rss3",
      worker   = "rss3",
      network  = "vsl",
      endpoint = "https://rpc.rss3.io"
    }
  ]


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
    endpoints = {
      ethereum = var.node_ethereum_endpoint
    }
    workers   = concat(local.ethereum_worker, local.internal_worker)

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
