

resource "random_string" "suffix" {
  length = 10
  upper = false
  special = false
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.storage_account_name}${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}
