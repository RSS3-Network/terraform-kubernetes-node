variable "namespace" {
  type        = string
  default     = "default"
  description = "The namespace to deploy the application and cockroachdb"
}

variable "crdb_storage_class" {
  type        = string
  default     = ""
  description = "kubernetes storage class for cockroachdb"
}

variable "crdb_disk_size" {
  type        = string
  default     = "100Gi"
  description = "The size of the disk for the cockroachdb"
}

// need to bigger than 3
variable "crdb_replicas" {
  type        = number
  default     = 3
  description = "The number of cockroachdb replicas"
  validation {
    condition     = var.crdb_replicas >= 3
    error_message = "Replicas must be greater than 3"
  }
}

variable "crdb_resources" {
  type = map(object({
    cpu    = string
    memory = string
  }))
  default = {
    requests = {
      cpu    = "2"
      memory = "8Gi"
    }
    limits = {
      cpu    = "2"
      memory = "8Gi"
    }
  }
  description = "The resources for the cockroachdb"
}

variable "crdb_extra_settings" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "The extra helm set flags"
}

variable "crdb_values" {
  type        = list(string)
  default     = []
  description = "The extra values for the cockroachdb"
}

variable "crdb_user" {
  type        = string
  default     = "roach"
  description = "The user for the cockroachdb"
}

variable "crdb_password" {
  type        = string
  default     = ""
  description = "Leave empty to create a random password"
  // strong password
  validation {
    // only not empty 
    condition     = length(var.crdb_password) >= 8 || var.crdb_password == ""
    error_message = "Password must be at least 8 characters"
  }
}

variable "crdb_database" {
  type        = string
  default     = "node"
  description = "The database for the cockroachdb"
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
