# Node with rpc header example

This is an example for customize the rpc endpoint http request header.
Use `node_rpc_endpoints` to specify the rpc endpoint and its http headers.

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes"

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
    }
  ]
}
```
