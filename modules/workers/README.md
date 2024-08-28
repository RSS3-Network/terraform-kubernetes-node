# Terraform Node Workers Module

This module handles the generation of workers configuration for RSS3 DSL Node.

## Usage

```terraform
module "workers" {
  source = "RSS3-Network/node/kubernetes//modules/workers"
}

module "node" {
    source = "RSS3-Network/node/kubernetes"

    node_workers = module.workers.outputs.ethereum
}
```

Then perform the following steps:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## Outputs

| Name     | Description                       |
| -------- | --------------------------------- |
| ethereum | The ethereum worker configuration |
| internal | The internal worker configuration |
