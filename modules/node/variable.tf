variable "namespace" {
  type    = string
  default = "default"
}

variable "crdb_operator_namespace" {
  type    = string
  default = "cockroach-operator"
}

variable "crdb_storage_class" {
  type    = string
  default = ""
}

variable "crdb_disk_size" {
  type    = string
  default = "100Gi"
}

// need to bigger than 3
variable "crdb_replicas" {
  type    = number
  default = 3
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
}

variable "crdb_extra_settings" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "crdb_values" {
  type    = list(string)
  default = []
}

variable "crdb_user" {
  type    = string
  default = "roach"
}

variable "crdb_password" {
  type    = string
  default = ""
  // strong password
  validation {
    // only not empty 
    condition     = length(var.crdb_password) >= 8 || var.crdb_password == ""
    error_message = "Password must be at least 8 characters"
  }
}

variable "crdb_database" {
  type    = string
  default = "node"
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
  type    = number
  default = 3
}

variable "node_rpc_endpoints" {
  type = map(object({
    url            = string
    http_headers   = map(string)
    http2_disabled = bool
  }))
  default = {}
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
}

variable "node_values" {
  type    = list(string)
  default = []

}
