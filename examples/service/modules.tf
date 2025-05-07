module "container_sas_token" {
  source  = "claranet/storage-sas-token/azurerm//modules/service"
  version = "x.x.x"

  expiration_start_date        = "2025-12-05T15:00:00Z" # Change this to create a new token
  expiration_duration_in_hours = 8760                   # 1 year
  storage_account_id           = module.storage.id

  service_type = "container"
  service_name = "container1"
  permissions  = ["read", "add", "create", "write", "delete", "delete versions", "permanent delete", "list", "tags", "find", "move", "execute", "ownership", "permissions", "set immutability policy", "update", "process", "query"]

}

module "share_sas_token" {
  source  = "claranet/storage-sas-token/azurerm//modules/service"
  version = "x.x.x"

  expiration_start_date        = "2025-12-05T15:00:00Z" # Change this to create a new token
  expiration_duration_in_hours = 8760                   # 1 year
  storage_account_id           = module.storage.id

  service_type = "share"
  service_name = "fileshare1"
  permissions  = ["read", "add", "create", "write", "delete", "delete versions", "permanent delete", "list", "tags", "find", "move", "execute", "ownership", "permissions", "set immutability policy", "update", "process", "query"]

}
