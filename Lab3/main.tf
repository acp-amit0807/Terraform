
# resource "azurerm_resource_group" "main" {
#   name     = "rg-${var.application_name}-${var.environment_name}"
#   location = var.primary_location
# }

module "resource_group" {
  source = "./modules/resource-group"
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}


module "storage_account" {
  source = "./modules/storage-account"

  storage_account_name = var.storage_account_name
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location

  account_tier       = var.account_tier
  replication_type   = var.replication_type
  tags               = var.tags
}