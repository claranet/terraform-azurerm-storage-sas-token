data "external" "main" {
  program = ["bash", "${path.module}/scripts/accounttoken.sh"]

  query = {
    storage_account_name = local.storage_account_name
    resource_group_name  = local.storage_account_id_parsed["resource_group_name"]
    permissions          = local.permissions
    expiry               = formatdate("YYYY-MM-DD'T'hh:mm:ssZ", timeadd(time_static.main.rfc3339, format("%dh", var.expiration_duration_in_hours)))
    start_time           = formatdate("YYYY-MM-DD'T'hh:mm:ssZ", var.expiration_start_date)
    resource_types       = local.resource_types
    services             = local.services
    storage_key_name     = var.storage_key_name
    subscription_id      = local.storage_account_subscription_id
  }
}
