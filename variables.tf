variable "storage_account_connection_string" {
  description = "Connection String of the Storage Account."
  type        = string
}

variable "sas_token_expiry" {
  description = "Storage Account SAS Token end date (expiry). Specifies the UTC datetime (Y-m-d'T'H:M'Z') at which the SAS becomes invalid."
  type        = string
  default     = "2042-01-01T00:00:00Z"
}

variable "storage_container" {
  description = "Storage Account Container to use in order to generate a Service SAS Token."
  type        = string
  default     = ""
}

variable "permissions_container" {
  description = "The permissions the Container SAS grants. Allowed values: (a)dd (c)reate (d)elete (l)ist (r)ead (w)rite. Can be combined."
  type        = string
  default     = "dlrw" # For an unknown reason, `acdlrw` is not supported.
}

variable "permissions_account" {
  description = "The permissions the Account SAS grants. Allowed values: (a)dd (c)reate (d)elete (l)ist (p)rocess (r)ead (u)pdate (w)rite. Can be combined."
  type        = string
  default     = "wlacu"
}

variable "resources_types" {
  description = "The resource types the Account SAS is applicable for. Allowed values: (s)ervice (c)ontainer (o)bject. Can be combined."
  type        = string
  default     = "sco"
}

variable "services" {
  description = "The storage services the Account SAS is applicable for. Allowed values: (b)lob (f)ile (q)ueue (t)able. Can be combined."
  type        = string
  default     = "bfqt"
}
