data "azurerm_storage_account" "storage" {
  count = var.enabled ? 1 : 0

  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "external" "generate_storage_sas_token" {
  count = var.enabled ? 1 : 0

  program = ["bash", "${path.module}/files/script_sas_token.sh"]

  query = {
    storage_account_name      = join("", data.azurerm_storage_account.storage.*.name)
    storage_connection_string = join("", data.azurerm_storage_account.storage.*.primary_connection_string)
    storage_container         = var.storage_container
    token_expiry              = var.sas_token_expiry
    services                  = var.services
    resources_types           = var.resources_types
    permissions_account       = var.permissions_account
    permissions_container     = var.permissions_container
  }
}
