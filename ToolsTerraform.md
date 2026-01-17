# ================================
# ONE BLOCK – ALL TERRAFORM CONCEPTS
# ================================

variable "env" {
  default = "prod" # change to "dev" to see different behavior
}

resource "azurerm_storage_account" "demo" {

  
  # RESOURCE CONTROL → count
  # prod = 1 account, non-prod = 2
  
  count = var.env == "prod" ? 1 : 2

  name                     = "stdemo${count.index}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  
  # CONDITIONS → ternary (? :)
  
  enable_https_traffic_only = var.env == "prod" ? true : false

  
  # OPTIONAL BLOCK → dynamic
  # Only created when env == prod
  
  dynamic "blob_properties" {
    for_each = var.env == "prod" ? [1] : []

    content {
      delete_retention_policy {
        days = 30
      }
    }
  }

  
  # RESOURCE CONTROL → lifecycle
  # Prevent deletion in prod
  
  lifecycle {
    prevent_destroy = var.env == "prod"
  }

  
  # RESOURCE CONTROL → depends_on
  
  depends_on = [
    azurerm_resource_group.rg
  ]
}
