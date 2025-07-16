variable "resources_types" {
  description = "The resource types the Account SAS is applicable for. Allowed values: service, container, object. Can be combined."
  type        = list(string)
  default     = ["service", "container", "object"]
  validation {
    condition = alltrue([
      for resource_type in var.resources_types :
      contains(["service", "container", "object"], resource_type)
    ])
    error_message = "Allowed values are: service, container, object."
  }
}

variable "services" {
  description = "The storage services the Account SAS is applicable for. Allowed values: `blob`, `file`, `queue`, `table`. Can be combined."
  type        = list(string)
  default     = ["blob", "file", "queue", "table"]
  validation {
    condition = alltrue([
      for service in var.services :
      contains(["blob", "file", "queue", "table"], service)
    ])
    error_message = "Allowed values are: blob, file, queue, table."
  }
}

variable "storage_key_name" {
  description = "Name of the storage key to use for generating the SAS token. Default is `key1`."
  type        = string
  default     = "key1"
  validation {
    condition     = contains(["key1", "key2"], var.storage_key_name)
    error_message = "Allowed values are: key1, key2."
  }
}

variable "storage_account_id" {
  description = "The storage account ID to generate the SAS token for."
  type        = string
  nullable    = false
}


variable "expiration_start_date" {
  description = "Date and time when the SAS token becomes valid. Should be an RFC3339 formatted string. Change this to trigger a new token."
  type        = string
  nullable    = false
}

variable "expiration_duration_in_hours" {
  description = "Duration in hours for which the SAS token will be valid. Default is 1 hour."
  type        = number
  default     = 1
}


variable "permissions" {
  description = "Permissions to grant for the service. Must be one of: `read`, `write`, `delete`, `list`, `add`, `create`, `update`, `process`."
  type        = list(string)
  validation {
    condition = alltrue([
      for permission in var.permissions :
      contains(keys(local.permissions_mapping), permission)
    ])
    error_message = "Allowed permissions are read, write, delete, list, add, create, update, process."
  }
}
