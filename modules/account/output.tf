output "resource" {
  description = "AzAPI resource action object."
  value       = data.azapi_resource_action.main
  sensitive   = true
}

output "sas_token" {
  description = "SAS Token for accessing the Storage Account."
  value       = data.azapi_resource_action.main.output.accountSasToken
}