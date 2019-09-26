data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "external" "generate_storage_sas_token" {
  program = ["bash", "${path.module}/script_sas_token.sh"]

  query = {
    storage_account_name      = data.azurerm_storage_account.storage.name
    storage_connection_string = data.azurerm_storage_account.storage.primary_connection_string
    token_expiry              = var.sas_token_expiry
  }
}
