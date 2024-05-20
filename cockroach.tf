
locals {
  default_value = {
    storage = {
      persistentVolume = {
        storageClass = var.crdb_storage_class
        size         = var.crdb_disk_size
      }
    }
    statefulset = {
      replicas  = var.crdb_replicas
      resources = var.crdb_resources
    }
    init = {
      provisioning = {
        enabled = true
        users = [
          {
            name     = var.crdb_user
            password = local.crdb_password
          }
        ]
        databases = [
          {
            name    = var.crdb_database
            options = ["encoding='utf-8'"]
            owners  = [var.crdb_user]
          }
        ]
      }
    }
  }
}




resource "helm_release" "cockroachdb" {
  name       = "cockroachdb"
  namespace  = var.namespace
  repository = "https://charts.cockroachdb.com/"
  chart      = "cockroachdb"
  version    = "12.0.5"

  wait          = false
  wait_for_jobs = true

  dynamic "set" {
    for_each = var.crdb_extra_settings
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  // merge with var.crdb_values
  values = concat(var.crdb_values, [
    yamlencode(local.default_value)
  ])

}

// output the database uri
locals {
  database_uri = "postgresql://${var.crdb_user}:${local.crdb_password}@cockroachdb-public.${var.namespace}.svc:26257/${var.crdb_database}?sslmode=require"
}
