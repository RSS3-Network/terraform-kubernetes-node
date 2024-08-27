variable "namespace" {
  type        = string
  default     = "default"
  description = "The namespace to deploy the application"
}
variable "google_project_id" {
  type        = string
  description = "The Google Cloud project ID"
}

variable "google_vpc_network_name" {
  type        = string
  default     = "default"
  description = "The name of VPC for AlloyDB"
}

variable "redis_enable" {
  type    = bool
  default = false
}

variable "redis_endpoint" {
  type    = string
  default = "127.0.0.1:6379"
}

variable "redis_username" {
  type    = string
  default = ""
}

variable "redis_password" {
  type    = string
  default = ""
}

variable "node_replicas" {
  type        = number
  default     = 3
  description = "node http server replicas"
}

variable "node_rpc_endpoints" {
  type = map(object({
    url            = string
    http_headers   = map(string)
    http2_disabled = bool
  }))
  default     = {}
  description = "rpc endpoints with http headers and http2 options"
}

variable "node_workers" {
  type = list(object({
    id       = string
    network  = string
    worker   = string
    endpoint = string

    parameters = optional(map(string), {})

    resources = optional(map(object({
      cpu    = string
      memory = string
    })), {})
  }))
  description = "The workers for the node"
}

variable "node_values" {
  type        = list(string)
  default     = []
  description = "The extra values for the node"
}

variable "node_register" {
  type        = bool
  default     = true
  description = "Register the node with the network"
}

variable "node_register_config" {
  type = object({
    operator = object({
      evm_address = string
      signature   = string
    })
    server = object({
      endpoint                = string
      global_indexer_endpoint = optional(string, "https://gi.rss3.io/")
    })
  })
  description = "The register config for the node"
}
