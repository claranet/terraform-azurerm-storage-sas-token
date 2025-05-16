output "module_service" {
  description = "Service sas token module output."
  value       = var.token_type == "service" ? module.service_token : null
  sensitive   = true
}

output "module_account" {
  description = "Account sas token module output."
  value       = var.token_type == "account" ? module.account_token : null
  sensitive   = true
}

output "sas_token" {
  description = "SAS Token for accessing the Storage Account."
  value       = var.token_type == "service" ? module.service_token.sas_token : module.account_token.sas_token
  sensitive   = true
}