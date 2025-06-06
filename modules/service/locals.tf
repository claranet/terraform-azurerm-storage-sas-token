locals {
  signed_resource = {
    container = {
      symbol                        = "c"
      canonicalized_resource_prefix = "/blob"
    }
    blob = {
      symbol                        = "b"
      canonicalized_resource_prefix = "/blob"
    }
    file = {
      symbol                        = "f"
      canonicalized_resource_prefix = "/file"
    }
    share = {
      symbol                        = "s"
      canonicalized_resource_prefix = "/file"
    }
    queue = {
      symbol                        = null
      canonicalized_resource_prefix = "/queue"
    }
    table = {
      symbol                        = null
      canonicalized_resource_prefix = "/table"
    }
  }

  permissions_mapping = {
    read = {
      symbol = "r"
      scope  = ["container", "directory", "blob", "file", "share", "queue"]
    }
    add = {
      symbol = "a"
      scope  = ["container", "directory", "blob", "queue", "table"]
    }
    create = {
      symbol = "c"
      scope  = ["container", "directory", "blob", "file", "share"]
    }
    write = {
      symbol = "w"
      scope  = ["container", "directory", "blob", "file", "share"]
    }
    delete = {
      symbol = "d"
      scope  = ["container", "directory", "blob", "file", "share", "table"]
    }
    "delete versions" = {
      symbol = "x"
      scope  = ["container", "blob"]
    }
    "permanent delete" = {
      symbol = "y"
      scope  = ["blob"]
    }
    list = {
      symbol = "l"
      scope  = ["container", "directory", "share"]
    }
    tags = {
      symbol = "t"
      scope  = ["blob"]
    }
    find = {
      symbol = "f"
      scope  = ["container", "directory"]
    }
    move = {
      symbol = "m"
      scope  = ["container", "directory", "blob"]
    }
    execute = {
      symbol = "e"
      scope  = ["container", "directory", "blob"]
    }
    ownership = {
      symbol = "o"
      scope  = ["container", "directory", "blob"]
    }
    permissions = {
      symbol = "p"
      scope  = ["container", "directory", "blob"]
    }
    "set immutability policy" = {
      symbol = "i"
      scope  = ["container", "blob"]
    }
    update = {
      symbol = "u"
      scope  = ["queue", "table"]
    }
    process = {
      symbol = "p"
      scope  = ["queue"]
    }
    query = {
      symbol = "r"
      scope  = ["table"]
    }
  }

  # Define the strict order for permissions symbols
  permissions_order = ["r", "a", "c", "w", "d", "x", "l", "t", "m", "e", "o", "p"]

  # Create a set of requested permissions that are valid for the service type
  valid_requested_permissions = toset([
    for permission in var.permissions :
    permission if contains(local.permissions_mapping[permission].scope, var.service_type)
  ])

  # Generate permissions string in strict order
  permissions = join("", [
    for symbol in local.permissions_order :
    symbol if anytrue([
      for permission, config in local.permissions_mapping :
      config.symbol == symbol && contains(local.valid_requested_permissions, permission)
    ])
  ])

  storage_account_id_parsed = provider::azapi::parse_resource_id("Microsoft.Storage/storageAccounts", var.storage_account_id)
  storage_account_name      = local.storage_account_id_parsed["name"]

  canonicalized_resource = format("%s/%s/%s", local.signed_resource[var.service_type].canonicalized_resource_prefix, local.storage_account_name, var.service_name)
}
