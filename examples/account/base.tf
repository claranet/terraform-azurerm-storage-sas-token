module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
}

module "storage" {
  source = "claranet/storage-account/azurerm"

  client_name           = var.client_name
  environment           = var.environment
  location              = module.azure_region.location
  location_short        = module.azure_region.location_short
  logs_destinations_ids = []
  resource_group_name   = module.rg.name
  stack                 = var.stack

  shared_access_key_enabled = true
}
