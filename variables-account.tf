variable "account_token_storage_key_name" {
  description = "Name of the storage key to use for generating the Service SAS token. Default is `key1`."
  type        = string
  default     = "key1"
  validation {
    condition     = contains(["key1", "key2"], var.account_token_storage_key_name)
    error_message = "Allowed values are: key1, key2."
  }
}

variable "account_token_resources_types" {
  description = "The resource types the Account SAS is applicable for. Allowed values: service, container, object. Can be combined."
  type        = list(string)
  default     = ["service", "container", "object"]
  validation {
    condition = alltrue([
      for resource_type in var.account_token_resources_types :
      contains(["service", "container", "object"], resource_type)
    ])
    error_message = "Allowed values are: service, container, object."
  }
}

variable "account_token_services" {
  description = "The storage services the Account SAS is applicable for. Allowed values: `blob`, `file`, `queue`, `table`. Can be combined."
  type        = list(string)
  default     = ["blob", "file", "queue", "table"]
  validation {
    condition = alltrue([
      for service in var.account_token_services :
      contains(["blob", "file", "queue", "table"], service)
    ])
    error_message = "Allowed values are: blob, file, queue, table."
  }
}
