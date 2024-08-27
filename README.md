# Terraform Node Module

This module helpers you create RSS3 DSL Node with AlloyDB, redis, and other services easily.  
The resources/services/activations/deletions that this module will create/trigger are:

- Create node helm chart release

## Compatibility

This module is meant for use with Terraform 0.14.

## Usage

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes"

  node_workers = [
    {
      id       = "crossbell",
      worker   = "crossbell",
      network  = "crossbell",
      endpoint = "https://rpc.crossbell.io"
    }
  ]

  database_uri = "postgres://node:node@alloydb:5432/node"
}
```

Then perform the following steps:

1. Run `terraform init` to get the necessary providers.
2. Run `terraform plan` to create the execution plan.
3. Run `terraform apply` to apply the execution plan.
4. Run `terraform destroy` to destroy the resources created by the execution plan.

More examples can be found in the [examples](./examples) directory.

## Inputs

| Name                      | Description                                       | Type              | Default                 | Required |
| ------------------------- | ------------------------------------------------- | ----------------- | ----------------------- | :------: |
| namespace                 | The namespace to deploy the application           | string            | default                 |    no    |
| redis_enable              |                                                   | bool              | false                   |    no    |
| redis_endpoint            |                                                   | string            |                         |          |
| redis_username            |                                                   | string            | ""                      |    no    |
| redis_password            |                                                   | string            | ""                      |    no    |
| node_replicas             | node http server replicas                         | number            | 3                       |    no    |
| node_rpc_endpoints        | rpc endpoints with http headers and http2 options | map(**endpoint**) | {}                      |    no    |
| node_workers              | The workers for the node                          | list(**worker**)  |                         |   yes    |
| node_values               | The extra values for the node                     | list(string)      | []                      |    no    |
| node_register             | Register the node with the network                | bool              | true                    |    no    |
| node_register_evm_address | The evm address to register the node with         | string            | ""                      |    no    |
| node_register_gi_address  | The gi address to register the node with          | string            | "<https://gi.rss3.io/>" |    no    |
| node_http_endpoint        | The http endpoint for the node                    | string            | ""                      |    no    |

### complicated object structure

- **endpoint**: object({ url = string http_headers = map(string) http2_disabled = bool })
- **worker**: object({ id = string network = string worker = string endpoint = string parameters = optional(map(string), {}) resources = optional(map(object({ cpu = string memory = string }))
