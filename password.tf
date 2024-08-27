// compatible with shells consider using only uppercase and lowercase letters
resource "random_password" "alloy_password" {
  length      = 16
  special     = false
  min_lower   = 4
  min_upper   = 4
  min_numeric = 4
}
