# =====================================================
# Variables
# =====================================================
variable "environment" {
  type    = string
  default = "Dev"
}

variable "resource_group_name" {
  type    = string
  default = "learning-resources"
}

# ----- Static Storage Account Variable -----
variable "static_storage_name" {
  type    = string
  default = "staticstoragevenkat434"
}

# ----- Dynamic Storage Accounts Variable -----
variable "dynamic_storage_accounts" {
  type = list(object({
    name             : string
    location         : string
    tier             : string
    replication_type : string
  }))
  default = [
    {
      name             = "dynamicazdevopsvenkat"
      location         = "UK West"
      tier             = "Standard"
      replication_type = "LRS"
    },
    {
      name             = "dynamicazdevopsvenkat1"
      location         = "North Europe"
      tier             = "Standard"
      replication_type = "GRS"
    }
  ]
}

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
# 1️⃣ Static Storage Account
# =====================================================
resource "azurerm_storage_account" "static_storage" {
  name                     = var.static_storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

# =====================================================
# 2️⃣ Dynamic Storage Accounts
# =====================================================
resource "azurerm_storage_account" "dynamic_storage" {
  for_each = { for acct in var.dynamic_storage_accounts : acct.name => acct }

  name                     = each.key
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = each.value.location
  account_tier             = each.value.tier
  account_replication_type = each.value.replication_type

  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

# =====================================================
# Outputs
# =====================================================
output "static_storage_name" {
  value = azurerm_storage_account.static_storage.name
}

output "dynamic_storage_names" {
  value = [for s in azurerm_storage_account.dynamic_storage : s.name]
}