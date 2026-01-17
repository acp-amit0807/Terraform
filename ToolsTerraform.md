## Goal (in plain English)

Create 1 or 2 storage accounts

If environment is prod:
  Enable soft delete
  Protect from delete

If not prod:
  Skip these

  `variable "env" {
  default = "prod"
}

resource "azurerm_storage_account" "demo" {

  # 1️⃣ RESOURCE CONTROL (count)
  count = var.env == "prod" ? 1 : 2

  name                     = "stdemo${count.index}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # 2️⃣ CONDITIONS (? :)
  enable_https_traffic_only = var.env == "prod" ? true : false

  # 3️⃣ OPTIONAL BLOCK (dynamic)
  dynamic "blob_properties" {
    for_each = var.env == "prod" ? [1] : []

    content {
      delete_retention_policy {
        days = 30
      }
    }
  }

  # 4️⃣ RESOURCE CONTROL (lifecycle)
  lifecycle {
    prevent_destroy = var.env == "prod"
  }

  # 5️⃣ DEPENDENCY
  depends_on = [
    azurerm_resource_group.rg
  ]
}
`

NOW UNDERSTAND THIS LINE BY LINE
1️⃣ count
count = var.env == "prod" ? 1 : 2


👉 PROD → 1 account
👉 NON-PROD → 2 accounts

2️⃣ ? : (Condition)
enable_https_traffic_only = var.env == "prod" ? true : false


👉 If prod → secure
👉 Else → relaxed

3️⃣ dynamic
for_each = var.env == "prod" ? [1] : []


👉 [1] → create block once
👉 [] → skip block

4️⃣ lifecycle
prevent_destroy = var.env == "prod"


👉 PROD → cannot delete
👉 NON-PROD → deletable

5️⃣ depends_on
depends_on = [azurerm_resource_group.rg]


👉 RG first, then storage

🧒 10-YEAR-OLD VERSION

“If this is PROD, make one storage box, lock it, and add safety.
If not, make two boxes and don’t lock them.”

🎯 THIS IS THE KEY TAKEAWAY
Concept	Where you saw it
Resource control	count, lifecycle, depends_on
Conditions	? :
Optional blocks	dynamic
Iteration	count.index