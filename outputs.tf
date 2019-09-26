output "storage_account_sas_token" {
  description = "SAS Token generated for access on Storage Account with full permissions on containers and objects for blob and table services."
  value       = data.external.generate_storage_sas_token.result
  sensitive   = true
}
