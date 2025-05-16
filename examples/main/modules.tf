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

  expiration_start_date          = time_static.main.rfc3339 # change this to trigger a new token
  expiration_duration_in_hours   = 1
  storage_account_id             = azurerm_storage_account.my_storage.id
  token_type                     = "account"
  account_token_resources_types  = ["service", "container", "object"]
  account_token_services         = ["blob", "file"]
  permissions                    = ["read", "list"]
  account_token_storage_key_name = "key2" # key1 or key2

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

  expiration_start_date = time_static.main.rfc3339 # change this to trigger a new token
  token_type            = "service"

  service_token_service_name = "mycontainer"
  service_token_service_type = "blob"
  storage_account_id         = azurerm_storage_account.my_storage.id
  permissions                = ["read", "list", "write", "append", "create", "delete"]

}


resource "time_static" "main" {}
