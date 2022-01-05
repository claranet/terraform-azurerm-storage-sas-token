terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 1.1.1"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.0"
    }
  }
}
