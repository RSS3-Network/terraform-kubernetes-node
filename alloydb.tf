resource "google_alloydb_cluster" "rss3" {
  cluster_id = "alloydb-cluster-rss3"
  location   = "us-central1"
  network_config {
    network = google_compute_network.rss3.id
  }
}

data "google_project" "project" {
}

resource "google_compute_network" "rss3" {
  name = "alloydb-cluster"
}

locals {
  database_uri = "postgresql://${google_alloydb_cluster.rss3.name}:${google_alloydb_cluster.rss3.password}@${google_alloydb_cluster.rss3.ip_address}:5432/${google_alloydb_cluster.rss3.database_name}"
}
