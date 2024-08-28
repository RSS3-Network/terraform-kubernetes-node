locals {
  arweave_mirror = {
    id       = "arweave-mirror"
    network  = "arweave"
    worker   = "mirror"
    endpoint = "https://arweave.net"

    resources = {
      requests = {
        cpu    = "500m"
        memory = "512Mi"
      }
      limits = {
        cpu    = "1"
        memory = "1Gi"
      }
    }
  }
  arweave_paragraph = {
    id       = "arweave-paragraph"
    network  = "arweave"
    worker   = "paragraph"
    endpoint = "https://arweave.net"
  }
  crossbell = {
    id       = "crossbell",
    worker   = "crossbell",
    network  = "crossbell",
    endpoint = "https://rpc.crossbell.io"
  }
  vsl_rss3 = {
    id       = "vsl-rss3",
    worker   = "rss3",
    network  = "vsl",
    endpoint = "https://rpc.rss3.io"
  }

  internal_worker = [
    local.arweave_mirror,
    local.arweave_paragraph,
    local.crossbell,
    local.vsl_rss3
  ]
}
