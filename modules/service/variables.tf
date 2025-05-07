variable "service_type" {
  description = "Type of the service to generate a SAS token for. Must be one of : container, blob, file, share."
  type        = string
  validation {
    condition     = contains(keys(local.signed_resource), var.service_type)
    error_message = "Allowed values are: container, blob, file, share."
  }
}

variable "permissions" {
  description = "Permissions to grant for the service. Must be one of : read, add, create, write, delete, delete version, permanent delete, list, tags, find, move, execute, ownership, permissions, set immutability policy, update, process, query."
  type        = list(string)
  validation {
    condition = alltrue([
      for permission in var.permissions :
      contains(keys(local.permissions_mapping), permission)
    ])
    error_message = "Allowed permissions are read, add, create, write, delete, delete version, permanent delete, list, tags, find, move, execute, ownership, permissions, set immutability policy, update, process, query."
  }
}

variable "expiration_duration_in_hours" {
  description = "Duration in hours for which the SAS token will be valid. Default is 1 hour."
  type        = number
  default     = 1
}

variable "expiration_start_date" {
  description = "Date and time when the SAS token becomes valid. Should be an RFC3339 formatted string."
  type        = string
  nullable    = false
}

variable "storage_account_id" {
  description = "ID of the Storage Account to generate the SAS token for."
  type        = string
  nullable    = false
}

variable "service_name" {
  description = "Name of the service to generate the SAS token for. It can be a container name, blob name, file share name, etc."
  type        = string
}