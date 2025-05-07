output "resource" {
  description = "AzAPI resource action object."
  value       = data.azapi_resource_action.main
  sensitive   = true
}

output "sas_token" {
  description = "Generated SAS token for accessing the Storage Account."
  value       = data.azapi_resource_action.main.output.serviceSasToken
  sensitive   = true
}