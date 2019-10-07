locals {
  sas_token         = var.enabled ? jsondecode(join("", regex("\"sastoken\":(\".*\")", jsonencode(data.external.generate_storage_sas_token)))) : null
  sas_uri_container = var.enabled && var.storage_container != "" ? "${join("", data.azurerm_storage_account.storage.*.primary_blob_endpoint)}${var.storage_container}${local.sas_token}" : null
}
