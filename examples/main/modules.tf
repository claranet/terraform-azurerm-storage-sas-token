module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

### Account SAS
resource "azurerm_storage_account" "my_storage" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = module.azure_region.location
  name                     = "mystorage"
  resource_group_name      = module.rg.resource_group_name
}

module "storage_sas_token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  storage_account_connection_string = azurerm_storage_account.my_storage.primary_connection_string
}

### Service SAS for a container
resource "azurerm_storage_container" "my_container" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.my_storage.name
  container_access_type = "private"
}

module "container_sas_token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  storage_account_connection_string = azurerm_storage_account.my_storage.primary_connection_string
  storage_container                 = azurerm_storage_container.my_container.name
}
