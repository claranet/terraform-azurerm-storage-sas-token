module "sas_token" {
  source  = "claranet/storage-sas-token/azurerm//modules/account"
  version = "x.x.x"

  expiration_start_date        = "2025-12-05T15:00:00Z"
  expiration_duration_in_hours = 8760 # 1 year
  storage_account_id           = module.storage.id

  resources_types  = ["service", "container", "object"]
  services         = ["blob", "file", "queue", "table"]
  storage_key_name = "key1" # key1 or key2
  permissions      = ["read", "list", "write", "add", "create", "update", "process"]
}
