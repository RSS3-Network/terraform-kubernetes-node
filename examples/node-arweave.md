# Node with arweave worker

This is a node with an arweave worker.

> arweave mirror worker minimum resources are 500m CPU and 512Mi memory.

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes"

  node_workers = [
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
    }
  ]
}

```
