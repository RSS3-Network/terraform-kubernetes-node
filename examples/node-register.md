# Node register to VSL

This is a node config register to VSL Chain.

variable "node_register_config" {
type = object({
operator = object({
evm_address = string
signature = string
})
server = object({
endpoint = string
global_indexer_endpoint = optional(string, "https://gi.rss3.io/")
})
})
description = "The register config for the node"
}

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes"

  node_register_config = {
    operator = {
      evm_address = "0x1234567890abcdef1234567890abcdef12345678"
        signature = "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
    }
    server = {
      endpoint = "https://your-node.custom-domain.com"
      # optional, default to "https://gi.rss3.io/", testnet use "https://gi.rss3.dev/"
      global_indexer_endpoint = "https://gi.rss3.io/"
      access_token = "<generate_random_access_token>"
    }
  }
}
```
