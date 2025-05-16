variable "service_token_service_name" {
  description = "Name of the service to generate the SAS token for. It can be a container name, blob name, file share name, etc."
  type        = string
  default     = ""
}

variable "service_token_service_type" {
  description = "Type of the service to generate a SAS token for. Must be one of : container, blob, file, share."
  type        = string
  default     = ""
}