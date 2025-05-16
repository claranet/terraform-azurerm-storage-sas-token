terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
  }
}
