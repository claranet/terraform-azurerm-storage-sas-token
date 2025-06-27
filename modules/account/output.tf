output "resource" {
  description = "External data source object."
  value       = data.external.main
  sensitive   = true
}

output "sas_token" {
  description = "SAS Token for accessing the Storage Account."
  value       = data.external.main.result.sas_token_with_prefix
  sensitive   = true
}
