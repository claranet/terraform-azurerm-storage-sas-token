locals {
  sa_name                  = split("=", var.storage_account_connection_string)[2]
  sa_primary_blob_endpoint = format("https://%s.blob.core.windows.net", local.sa_name)

  sas_token         = jsondecode(join("", regex("\"sastoken\":(\".*\")", jsonencode(data.external.generate_storage_sas_token))))
  sas_uri_container = var.storage_container != "" ? "${join("", local.sa_primary_blob_endpoint)}${var.storage_container}${local.sas_token}" : null
}
