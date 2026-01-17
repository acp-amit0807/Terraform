# Terraform Memory Guide 🧠  
### Learn Terraform Core Concepts Through a Simple Story

This repository contains a **1-page mental model** to understand and remember **core Terraform concepts** without memorizing syntax.

The goal is to help beginners and experienced engineers **think in Terraform**, not just write it.

---

## 📖 The Story: The Smart Warehouse

Think of every cloud resource as a **warehouse**.

Terraform is the **rulebook** that decides:
- How many warehouses to build
- Which ones are secure
- Which ones are optional
- Which ones must never be destroyed

Before Terraform builds anything, it always answers **5 simple questions**.

---

## 1️⃣ How many resources should I create?
### Resource Control → `count`, `for_each`

Terraform first decides **quantity**.

```hcl
count = var.env == "prod" ? 1 : 2


PROD → create only 1 (be careful)

NON-PROD → create more (safe to experiment)

🧠 Memory: Quantity decision

2️⃣ Should I repeat or filter data?
Iteration → for, for_each, if

Terraform loops over data and keeps only what matches.

[for x in items : x if x.env == "prod"]


for → loop

if → filter

🧠 Memory: Repeat + Filter

3️⃣ Is this a Yes / No decision?
Conditions → ? :, can(), try()

Terraform decides values using conditions.

var.env == "prod" ? true : false


Safe fallback:

try(var.value, 0)


Existence check:

can(var.optional_value)


🧠 Memory: Agar / Warna / Try

4️⃣ How do I clean and shape data?
Data Handling → map, list, set, lookup, merge, flatten, compact

Terraform cleans messy inputs before using them.

merge(common_tags, env_tags)

flatten([[1,2],[3]])

compact(["a", "", null, "b"])


🧠 Memory: Data Safai (clean & organize)

5️⃣ Should I add something only sometimes?
Optional Blocks → dynamic

Terraform cannot write if block, so it uses dynamic.

dynamic "block_name" {
  for_each = condition ? [1] : []
  content {
    # block configuration
  }
}


[1] → create block once

[] → skip block

🧠 Memory: Kabhi hai, kabhi nahi

🛡️ Extra Safety Rules (Still Resource Control)
🔒 lifecycle

Protect important resources from deletion.

lifecycle {
  prevent_destroy = true
}


Meaning: Terraform will refuse to destroy this resource

⏱️ depends_on

Ensure correct creation order.

depends_on = [resource_group]


Meaning: First land, then building

🌍 provider

Defines which cloud / account / region builds the resource.