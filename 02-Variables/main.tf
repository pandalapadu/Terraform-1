
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.49"
    }
  }
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "learning-tf-rg"
#     storage_account_name = "azdevops12574"
#     container_name       = "tfstate"
#     key                  = "dev.tfstate"
#   }
# }


provider "azurerm" {
  features {}
  subscription_id = "af504235-2f6d-4469-aa25-251f498730fc"
}

variable "environment" {
  type = string
  description = "this is environment value"
  default = "Dev"
}

resource "azurerm_resource_group" "rg" {
  name     = "learning-resources"
  location = "UK West"
}

resource "azurerm_storage_account" "storage_account" {
  # depends_on = [ azurerm_resource_group.rg ]
  name                     = "azdevopsvenkat"
  resource_group_name      = azurerm_resource_group.rg.name  # implicit dependency
  location                 = azurerm_resource_group.rg.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Dev"
  }
}