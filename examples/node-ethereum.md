# Node with ethereum worker

This is a node with an ethereum worker.

There are serval of workers for ethereum

- **rss3**
- **opensea** require 200m CPU and 512Mi memory
- **uniswap** require 1core CPU and 1Gi memory, 2core CPU and 2Gi memory is recommended
- **optimism**
- **core** require 2core CPU and 2Gi memory, 4core CPU and 4Gi memory is recommended
- **highlight** require 500m CPU and 512Mi memory, 1core CPU and 1Gi memory is recommended
- **looksrare**
- **lido**
- **aave**
- **1inch**
- **vsl**
- **stargate**
- **curve**

```terraform
module "node" {
  source = "RSS3-Network/modules/node"

  node_rpc_endpoints = {
    ethereum = {
      url = "<ethereum_rpc_url>"
      http_headers = {
        "x-api-key" = "<api-key>"
      }
    }
  }

  node_workers = [
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
}

```
