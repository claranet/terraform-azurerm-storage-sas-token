variable "permissions" {
  description = "Permissions to grant for the service. Must be one of: read, add, create, write, delete, delete version, permanent delete, list, tags, find, move, execute, ownership, permissions, set immutability policy, update, process, query."
  type        = list(string)
  default     = ["read", "append", "create", "write", "delete", "list"]
}

variable "token_type" {
  description = "Type of the token to generate. Must be one of: account, service."
  type        = string
  default     = "service"
  validation {
    condition     = contains(["account", "service"], var.token_type)
    error_message = "Allowed values are: `account`, `service`."
  }
}

variable "expiration_start_date" {
  description = "Date and time when the SAS token becomes valid. Should be an RFC3339 formatted string. Change this to trigger a new token."
  type        = string
  nullable    = false
}

variable "storage_account_id" {
  description = "ID of the Storage Account to generate the SAS token for."
  type        = string
  nullable    = false
}

variable "expiration_duration_in_hours" {
  description = "Duration in hours for which the SAS token will be valid. Default is 1 hour."
  type        = number
  default     = 1
}
