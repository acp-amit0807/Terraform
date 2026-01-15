
variable "application_name" {
  type = string
}

variable "location" {
  description = "Azure region"
  type        = string
}


variable "environment_name" {
  type = string
}

variable "primary_location" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "GRS"
}

variable "tags" {
  type    = map(string)
  default = {}
}