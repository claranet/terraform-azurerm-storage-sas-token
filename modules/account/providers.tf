terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.14"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.3"
    }
  }
}
