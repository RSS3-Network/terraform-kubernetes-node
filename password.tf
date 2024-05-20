// compatible with shells consider using only uppercase and lowercase letters
resource "random_password" "crdb_password" {
  length      = 16
  special     = false
  min_lower   = 4
  min_upper   = 4
  min_numeric = 4
}

locals {
  // random password for the user if not provided
  crdb_password = var.crdb_password != "" ? var.crdb_password : random_password.crdb_password.result
}
