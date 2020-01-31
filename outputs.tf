output "storage_account_sas_token" {
  description = "SAS Token generated for access on Storage Account."
  value       = local.sas_token
  sensitive   = true
}

output "storage_account_sas_container_uri" {
  description = "SAS URI generated for access on Storage Account Container."
  value       = local.sas_uri_container
  sensitive   = true
}
