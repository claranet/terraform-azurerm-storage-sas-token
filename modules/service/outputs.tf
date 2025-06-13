output "resource" {
  description = "External data source object."
  value       = data.external.main
  sensitive   = true
}

output "sas_token" {
  description = "Generated SAS token for accessing the Storage Account."
  value       = data.external.main.result.sas_token_with_prefix
  sensitive   = true
}
