terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "learning-resources"
  location = "UK West"
}

resource "azurerm_storage_account" "example" {

  name                     = "azdevopsvenkat"
  resource_group_name      = azurerm_resource_group.rg.name  # implicit dependency
  location                 = azurerm_resource_group.rg.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Dev"
  }
}