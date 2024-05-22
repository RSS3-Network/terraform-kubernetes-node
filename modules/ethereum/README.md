# Terraform Node Ethereum Submodule

This module helpers you create RSS3 DSL Node with cockroachdb, redis, and other services easily.  
The resources/services/activations/deletions that this module will create/trigger are:

- Create cockroachdb helm chart release
- Create node helm chart release

## Compatibility

This module is meant for use with Terraform 0.14.

## Usage

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes//modules/ethereum"

  crdb_disk_size     = "500Gi"
  crdb_storage_class = "premium-rwo"
  crdb_resources = {
    requests = {
      cpu    = "8"
      memory = "32Gi"
    }
    limits = {
      cpu    = "8"
      memory = "32Gi"
    }
  }

  node_ethereum_endpoint = {
    url = "https://your-ethereum-rpc"
    http_headers = {
      "key" = "value"
    }
  }

  node_register_config = {
    maintainer = {
      evm_address = "0x1234567890abcdef1234567890abcdef12345678"
      signature   = "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
    }
    server = {
      endpoint = "https://your-node.custom-domain.com"
      # optional, default to "https://gi.rss3.io/", testnet use "https://gi.rss3.dev/"
      global_indexer_endpoint = "https://gi.rss3.io/"
    }
  }

}
```

Then perform the following steps:

1. Run `terraform init` to get the necessary providers.
2. Run `terraform plan` to create the execution plan.
3. Run `terraform apply` to apply the execution plan.
4. Run `terraform destroy` to destroy the resources created by the execution plan.

More examples can be found in the [examples](./examples) directory.

## Inputs

| Name                   | Description                                             | Type                                                                                                                                                                                    | Default                                                                                                                                  | Required |
| ---------------------- | ------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| namespace              | The namespace to deploy the application and cockroachdb | `string`                                                                                                                                                                                | `"default"`                                                                                                                              |    no    |
| crdb_storage_class     | kubernetes storage class for cockroachdb                | `string`                                                                                                                                                                                | `""`                                                                                                                                     |    no    |
| crdb_disk_size         | The size of the disk for the cockroachdb                | `string`                                                                                                                                                                                | `"100Gi"`                                                                                                                                |    no    |
| crdb_replicas          | The number of cockroachdb replicas                      | `number`                                                                                                                                                                                | `3`                                                                                                                                      |    no    |
| crdb_resources         | The resources for the cockroachdb                       | `map(object({ cpu = string memory = string }))`                                                                                                                                         | <pre>{<br> "limits": {<br> "cpu": "2",<br> "memory": "8Gi"<br> },<br> "requests": {<br> "cpu": "2",<br> "memory": "8Gi"<br> }<br>}</pre> |    no    |
| crdb_extra_settings    | The extra helm set flags                                | `list(object({ name = string value = string }))`                                                                                                                                        | `[]`                                                                                                                                     |    no    |
| crdb_values            | The extra values for the cockroachdb                    | `list(string)`                                                                                                                                                                          | `[]`                                                                                                                                     |    no    |
| crdb_user              | The user for the cockroachdb                            | `string`                                                                                                                                                                                | `"roach"`                                                                                                                                |    no    |
| crdb_password          | Leave empty to create a random password                 | `string`                                                                                                                                                                                | `""`                                                                                                                                     |    no    |
| crdb_database          | The database for the cockroachdb                        | `string`                                                                                                                                                                                | `"node"`                                                                                                                                 |    no    |
| redis_enable           | Enable redis                                            | `bool`                                                                                                                                                                                  | `false`                                                                                                                                  |    no    |
| redis_endpoint         | The redis endpoint                                      | `string`                                                                                                                                                                                | `"node-redis:6379"`                                                                                                                      |    no    |
| redis_username         | The redis username                                      | `string`                                                                                                                                                                                | `""`                                                                                                                                     |    no    |
| redis_password         | The redis password                                      | `string`                                                                                                                                                                                | `""`                                                                                                                                     |    no    |
| node_replicas          | The number of node replicas                             | `number`                                                                                                                                                                                | `3`                                                                                                                                      |    no    |
| node_ethereum_endpoint | The ethereum endpoint for the node                      | `object({ url = string http_headers = map(string) http2_disabled = bool })`                                                                                                             | n/a                                                                                                                                      |   yes    |
| node_values            | The extra values for the node                           | `list(string)`                                                                                                                                                                          | `[]`                                                                                                                                     |    no    |
| node_register          | Register the node with the network                      | `bool`                                                                                                                                                                                  | `true`                                                                                                                                   |    no    |
| node_register_config   | The register config for the node                        | `object({ maintainer = object({ evm_address = string signature = string }) server = object({ endpoint = string global_indexer_endpoint = optional(string, "https://gi.rss3.io/") }) })` | n/a                                                                                                                                      |   yes    |
