# Node with VSL worker

This is a node with a VSL worker.

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes"

  node_workers = [
    {
      id       = "vsl-rss3",
      worker   = "rss3",
      network  = "vsl",
      endpoint = "https://rpc.rss3.io"
    }
  ]
}
```
