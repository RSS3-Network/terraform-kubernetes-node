locals {
  ethereum_rss3 = {
    network  = "ethereum"
    worker   = "rss3"
    id       = "ethereum-rss3"
    endpoint = "ethereum"
  }
  ethereum_opensea = {
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
  }
  ethereum_uniswap = {
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
  }

  ethereum_optimism = {
    network  = "ethereum"
    worker   = "optimism"
    id       = "ethereum-optimism"
    endpoint = "ethereum"
  }
  ethereum_core = {
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
  }
  ethereum_highlight = {
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
  }
  ethereum_looksrare = {
    network  = "ethereum"
    worker   = "looksrare"
    id       = "ethereum-looksrare"
    endpoint = "ethereum"
  }
  ethereum_lido = {
    network  = "ethereum"
    worker   = "lido"
    id       = "ethereum-lido"
    endpoint = "ethereum"
  }
  ethereum_aave = {
    network  = "ethereum"
    worker   = "aave"
    id       = "ethereum-aave"
    endpoint = "ethereum"
  }
  ethereum_1inch = {
    network  = "ethereum"
    worker   = "1inch"
    id       = "ethereum-1inch"
    endpoint = "ethereum"
  }

  ethereum_workers = [
    local.ethereum_1inch,
    local.ethereum_aave,
    local.ethereum_core,
    local.ethereum_highlight,
    local.ethereum_lido,
    local.ethereum_looksrare,
    local.ethereum_opensea,
    local.ethereum_optimism,
    local.ethereum_rss3,
    local.ethereum_uniswap,
  ]
}
