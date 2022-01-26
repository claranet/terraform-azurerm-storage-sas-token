data "external" "generate_storage_sas_token" {

  program = ["bash", "${path.module}/files/script_sas_token.sh"]

  query = {
    storage_account_name      = local.sa_name
    storage_connection_string = var.storage_account_connection_string
    storage_container         = var.storage_container
    token_expiry              = var.sas_token_expiry
    services                  = var.services
    resources_types           = var.resources_types
    permissions_account       = var.permissions_account
    permissions_container     = var.permissions_container
  }
}


