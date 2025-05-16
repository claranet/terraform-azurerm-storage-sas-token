locals {

  permissions_mapping = {
    read    = "r"
    write   = "w"
    delete  = "d"
    list    = "l"
    add     = "a"
    create  = "c"
    update  = "u"
    process = "p"
  }

  permissions = join("", [for permission in var.permissions : local.permissions_mapping[permission]])

  resource_types_mapping = {
    container = "c"
    service   = "s"
    object    = "o"
  }

  resource_types = join("", [for resource_type in var.resources_types : local.resource_types_mapping[resource_type]])

  services_mapping = {
    blob  = "b"
    file  = "f"
    queue = "q"
    table = "t"
  }

  services = join("", [for service in var.services : local.services_mapping[service]])

}