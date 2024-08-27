variable "project_id" {
  type        = string
  description = "The Google Cloud project ID"
}

variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
  default     = "dsl"
}

variable "regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!)"
  default     = true
}

variable "region" {
  type        = string
  description = "The region to host the cluster in (optional if zonal cluster / required if regional)"
  default     = "us-central1"
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
  default     = []
}

variable "subnet_ip" {
  type        = string
  description = "The subnet IP range"
  default     = "10.0.0.0/17"
}

variable "pod_ip_range" {
  type        = string
  description = "The pod IP range"
  default     = "192.168.0.0/18"
}

variable "service_ip_range" {
  type        = string
  description = "The service IP range"
  default     = "192.168.64.0/18"
}

variable "alloydb_cpu_count" {
  type        = number
  description = "The number of CPU cores for the AlloyDB"
  default     = 8
}

variable "redis_enable" {
  type    = bool
  default = true
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
