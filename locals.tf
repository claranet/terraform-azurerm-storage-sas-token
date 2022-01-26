locals {
  sas_token         = jsondecode(join("", regex("\"sastoken\":(\".*\")", jsonencode(data.external.generate_storage_sas_token))))
  sas_uri_container = var.storage_container != "" ? "${join("", var.storage_account_primary_blob_endpoint)}${var.storage_container}${local.sas_token}" : null
}
