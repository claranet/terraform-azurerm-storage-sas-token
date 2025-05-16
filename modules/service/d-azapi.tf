data "azapi_resource_action" "main" {
  type        = "Microsoft.Storage/storageAccounts@2024-01-01"
  resource_id = var.storage_account_id
  action      = "listServiceSas"
  method      = "POST"
  body = {
    signedPermission      = local.permissions
    signedExpiry          = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'", timeadd(time_static.main.rfc3339, format("%dh", var.expiration_duration_in_hours)))
    canonicalizedResource = local.canonicalized_resource
    signedVersion         = "2025-05-05"
    signedProtocol        = "https"
    signedResource        = local.signed_resource[var.service_type].symbol
  }
  response_export_values = ["*"]
}
