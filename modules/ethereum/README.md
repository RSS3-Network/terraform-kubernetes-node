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
  source = "RSS3-Network/node/kubernetes"

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

}
```

Then perform the following steps:

1. Run `terraform init` to get the necessary providers.
2. Run `terraform plan` to create the execution plan.
3. Run `terraform apply` to apply the execution plan.
4. Run `terraform destroy` to destroy the resources created by the execution plan.

More examples can be found in the [examples](./examples) directory.

## Inputs

| Name                      | Description                                             | Type                                                              | Default                                                                           | Required |
| ------------------------- | ------------------------------------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------------------------------- | :------: |
| namespace                 | The namespace to deploy the application and cockroachdb | string                                                            | default                                                                           |    no    |
| crdb_storage_class        | kubernetes storage class for cockroachdb                | string                                                            | ""                                                                                |    no    |
| crdb_disk_size            | The size of the disk for the cockroachdb                | string                                                            | 100Gi                                                                             |    no    |
| crdb_replicas             | The number of cockroachdb replicas                      | number                                                            | 3                                                                                 |    no    |
| crdb_resources            | The resources for the cockroachdb                       | map(object({ cpu = string memory = string }))                     | { requests = { cpu = "2" memory = "8Gi" } limits = { cpu = "2" memory = "8Gi" } } |    no    |
| crdb_extra_settings       | The extra helm set flags                                | list(object({ name = string value = string }))                    | []                                                                                |    no    |
| crdb_values               | The extra values for the cockroachdb                    | list(string)                                                      | []                                                                                |    no    |
| crdb_user                 | The user for the cockroachdb                            | string                                                            | roach                                                                             |    no    |
| crdb_password             | Leave empty to create a random password                 | string                                                            | ""                                                                                |    no    |
| crdb_database             | The database for the cockroachdb                        | string                                                            | node                                                                              |    no    |
| redis_enable              |                                                         | bool                                                              | false                                                                             |    no    |
| redis_endpoint            |                                                         | string                                                            |
| redis_username            |                                                         | string                                                            | ""                                                                                |    no    |
| redis_password            |                                                         | string                                                            | ""                                                                                |    no    |
| node_replicas             | node http server replicas                               | number                                                            | 3                                                                                 |    no    |
| node_rpc_endpoints        | rpc endpoints with http headers and http2 options       | { url = string http_headers = map(string) http2_disabled = bool } | {}                                                                                |    no    |
| node_values               | The extra values for the node                           | list(string)                                                      | []                                                                                |    no    |
| node_register             | Register the node with the network                      | bool                                                              | true                                                                              |    no    |
| node_register_evm_address | The evm address to register the node with               | string                                                            | ""                                                                                |    no    |
| node_register_gi_address  | The gi address to register the node with                | string                                                            | "https://gi.rss3.io/"                                                             |    no    |
| node_http_endpoint        | The http endpoint for the node                          | string                                                            | ""                                                                                |    no    |
