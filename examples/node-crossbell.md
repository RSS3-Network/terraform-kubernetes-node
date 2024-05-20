# Node with crossbell worker

This is a node with a crossbell worker.

```terraform
module "node" {
  source = "RSS3-Network/modules/node"

  node_workers = [
    {
      id       = "crossbell",
      worker   = "crossbell",
      network  = "crossbell",
      endpoint = "https://rpc.crossbell.io"
    }
  ]

}
```
