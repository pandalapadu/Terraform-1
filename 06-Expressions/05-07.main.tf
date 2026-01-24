# =====================================================
# Resource Group
# =====================================================
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.dynamic_storage_accounts[0].location  # Pick first dynamic account location

  tags = {
    environment = var.environment
  }
}

# =====================================================
# 1️⃣ Static Storage Account - count — use when you only care about how many
# N identical resources, and you don’t care about unique names or keys.
# =====================================================
resource "azurerm_storage_account" "static_storage" {
  name                     = var.static_storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  #allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

# =====================================================
# 2️⃣ Dynamic Storage Accounts - use when each resource must be uniquely identified
# You have a map or set, and each resource needs a stable key.
# =====================================================
resource "azurerm_storage_account" "dynamic_storage" {
  for_each = { for acct in var.dynamic_storage_accounts : acct.name => acct }

  name                     = each.key
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = each.value.location
  account_tier             = each.value.tier
  account_replication_type = each.value.replication_type

  #allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    environment = var.environment
  }
}
#Use for_each when:
 #     - Each resource has a unique name
  #    - You want predictable lifecycle behavior
  #    - You might add/remove items later
# =====================================================
# 3️⃣ Dynamic Storage Accounts (list<string>) - NOT a meta-argument (but often used with them)
# =====================================================
resource "azurerm_storage_account" "dynamic_storage_list" {
  count = length(var.dynamic_storage_accounts_list)

  name                     = var.dynamic_storage_accounts_list[count.index]
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  #allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    environment = var.environment
  }
}
# Use length() when:
# You need a number
# You’re converting a list → count
#⚠️ length is a function, not a meta-argument.
# =====================================================
# Outputs
# =====================================================
output "static_storage_name" {
  value = azurerm_storage_account.static_storage.name
}

output "dynamic_storage_names" {
  value = [for s in azurerm_storage_account.dynamic_storage : s.name]
}

output "dynamic_storage_list_names" {
  value = [for s in azurerm_storage_account.dynamic_storage_list : s.name]
}

# Count = length(var.static_storage_name)
# for_each = var.static_storage_name
# name = var.static_storage_name(count.index)