terraform {
  required_version = ">= 1.3"
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = ">= 2.0"
    }
  }
}
