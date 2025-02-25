### Account SAS
resource "azurerm_storage_account" "my_storage" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = module.azure_region.location
  name                     = "mystorage"
  resource_group_name      = module.rg.name
  min_tls_version          = "TLS1_2"
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
