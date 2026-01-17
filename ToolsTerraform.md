
## 1️⃣ Input Variable (Data Handling: map, list)
variable "storage_accounts" {
  type = map(object({
    env        = string
    ip_rules  = list(string)
  }))
}


Example value:

storage_accounts = {
  stprod = {
    env       = "prod"
    ip_rules = ["10.0.0.0/24"]
  }
  stdev = {
    env       = "dev"
    ip_rules = []
  }
}

2️⃣ Locals (Iteration + Data Handling)
locals {
  # iteration + if
  prod_accounts = {
    for name, cfg in var.storage_accounts :
    name => cfg if cfg.env == "prod"
  }

  # data handling
  common_tags = {
    owner = "platform"
  }
}

3️⃣ Resource (USES ALL CONCEPTS)
resource "azurerm_storage_account" "sa" {
  # Resource control
  for_each = var.storage_accounts

  name                     = each.key
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Conditions (? :)
  enable_https_traffic_only = each.value.env == "prod" ? true : false

  # Data handling (merge)
  tags = merge(
    local.common_tags,
    { env = each.value.env }
  )

  # Optional block (dynamic)
  dynamic "blob_properties" {
    for_each = each.value.env == "prod" ? [1] : []

    content {
      delete_retention_policy {
        days = 30
      }
    }
  }

  # Optional block (dynamic)
  dynamic "network_rules" {
    for_each = each.value.env == "prod" ? [1] : []

    content {
      default_action = "Deny"
      ip_rules       = each.value.ip_rules
    }
  }

  # Lifecycle (resource control)
  lifecycle {
    prevent_destroy = each.value.env == "prod"
  }

  # Explicit dependency
  depends_on = [
    azurerm_resource_group.rg
  ]
}

🧠 NOW LET’S MAP EACH CONCEPT (THIS IS THE KEY)
✅ Resource Control

for_each → multiple accounts

depends_on → order

lifecycle.prevent_destroy → protect PROD

🔁 Iteration

for_each → loop storage accounts

for ... if → filter prod accounts in locals

🚦 Conditions

env == "prod" ? true : false

Used for:

HTTPS enforcement

Soft delete

Network rules

📦 Data Handling

map → storage_accounts

list → ip_rules

merge() → tags

for + if → filtered locals

🧩 Optional Blocks

dynamic "blob_properties" → soft delete only in PROD

dynamic "network_rules" → security only in PROD

[1] → create once

[] → skip