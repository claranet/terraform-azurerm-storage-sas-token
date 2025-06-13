data "azapi_resource_action" "main" {
  type        = "Microsoft.Storage/storageAccounts@2024-01-01"
  resource_id = var.storage_account_id
  action      = "ListAccountSas"
  method      = "POST"
  body = {
    signedExpiry        = formatdate("YYYY-MM-DD'T'hh:mm:ssZ", timeadd(time_static.main.rfc3339, format("%dh", var.expiration_duration_in_hours)))
    signedPermission    = local.permissions
    signedResourceTypes = local.resource_types
    signedServices      = local.services
    keyToSign           = var.storage_key_name
    signedProtocol      = "https"
    signedStart         = var.expiration_start_date
  }
  response_export_values = ["*"]
}
