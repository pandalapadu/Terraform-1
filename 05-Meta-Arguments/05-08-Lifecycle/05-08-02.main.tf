resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
  }
}
# 1️ create_before_destroy
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    environment = var.environment
  }
}
#change account_replication_type → LRS to GRS show no downtime behavior
# 2️⃣ prevent_destroy
lifecycle {
  prevent_destroy = true
}
#run terraform destroy → ❌ blocked
# “Protect prod data”

#3️⃣ ignore_changes
lifecycle {
  ignore_changes = [
    tags
  ]
}
#modify tags in Azure Portal → terraform plan shows no diff
#4️⃣ replace_triggered_by
lifecycle {
  replace_triggered_by = [
    azurerm_resource_group.rg.id
  ]
}
#5️⃣ precondition
lifecycle {
  precondition {
    condition     = var.environment != "Prod" || startswith(self.name, "prod")
    error_message = "Production storage accounts must start with 'prod'"
  }
}
#set environment = "Prod" → invalid name → ❌ plan fails
#6️⃣ postcondition
lifecycle {
  postcondition {
    condition     = self.primary_blob_endpoint != ""
    error_message = "Storage account must expose a blob endpoint"
  }
}
