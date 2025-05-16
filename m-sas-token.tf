module "service_token" {
  count                        = var.token_type == "service" ? 1 : 0
  source                       = "./modules/service"
  expiration_start_date        = var.expiration_start_date
  permissions                  = var.permissions
  service_name                 = var.service_token_service_name
  service_type                 = var.service_token_service_type
  storage_account_id           = var.storage_account_id
  expiration_duration_in_hours = var.expiration_duration_in_hours

}

module "account_token" {
  count                        = var.token_type == "account" ? 1 : 0
  source                       = "./modules/account"
  expiration_start_date        = var.expiration_start_date
  storage_account_id           = var.storage_account_id
  permissions                  = var.permissions
  resources_types              = var.account_token_resources_types
  services                     = var.account_token_services
  storage_key_name             = var.account_token_storage_key_name
  expiration_duration_in_hours = var.expiration_duration_in_hours
}
