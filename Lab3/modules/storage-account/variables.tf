variable "storage_account_name" {
  description = "Base name of storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
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
