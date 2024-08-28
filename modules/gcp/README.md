# Terraform Node GCP Module

This module handles all GCP resources for RSS3 DSL Node.The resources include:

- Create a network(and subnetworks)
- Creates an AlloyDB Cluster
- Creates a GKE Cluster
- Create a redis instance
- Create node helm chart release

## Compatibility

This module is meant for use with Terraform 0.14.

## Usage

```terraform
module "node" {
  source = "RSS3-Network/node/kubernetes"

  project_id = "<PROJECT_ID>"

  node_workers = [
    {
      id       = "crossbell",
      worker   = "crossbell",
      network  = "crossbell",
      endpoint = "https://rpc.crossbell.io"
    }
  ]

  node_register_config = {
    operator = {
      evm_address = "0x1234567890abcdef1234567890abcdef12345678"
      signature   = "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
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

Then perform the following steps:

1. Run `terraform init` to get the necessary providers.
2. Run `terraform plan` to create the execution plan.
3. Run `terraform apply` to apply the execution plan.
4. Run `terraform destroy` to destroy the resources created by the execution plan.

More examples can be found in the [examples](./examples) directory.

## Inputs

| Name               | Description                                       | Type              | Default         | Required |
| ------------------ | ------------------------------------------------- | ----------------- | --------------- | :------: |
| project_id         | The Google Cloud project ID                       | string            |                 |   yes    |
| cluster_name       | The name of the GKE cluster                       | string            | dsl             |    no    |
| regional           | Whether is a regional cluster                     | bool              | true            |    no    |
| region             | The region to host the cluster in                 | string            | us-central1     |    no    |
| zones              | The zones to host the cluster in                  | list(string)      | []              |    no    |
| subnet_ip          | The subnet IP range                               | string            | 10.0.0.0/17     |    no    |
| pod_ip_range       | The pod IP range                                  | string            | 192.168.0.0/18  |    no    |
| service_ip_range   | The service IP range                              | string            | 192.168.64.0/18 |    no    |
| alloydb_cpu_count  | The number of CPU cores for the AlloyDB           | number            | 8               |    no    |
| redis_enable       | Whether to enable the redis instance              | bool              | true            |    no    |
| node_workers       | The workers for the node                          | list(**worker**)  |                 |   yes    |
| node_rpc_endpoints | rpc endpoints with http headers and http2 options | map(**endpoint**) | {}              |    no    |

### complicated object structure

- **endpoint**: object({ url = string http_headers = map(string) http2_disabled = bool })
- **worker**: object({ id = string network = string worker = string endpoint = string parameters = optional(map(string), {}) resources = optional(map(object({ cpu = string memory = string }))
