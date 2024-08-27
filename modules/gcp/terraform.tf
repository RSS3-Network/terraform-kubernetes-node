terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.36.0"
    }

  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
}

