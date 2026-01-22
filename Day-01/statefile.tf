# Best Practice:
# The storage account must be pre-created.
# Terraform should only reference it, not create it in this main.tf file configuration.
##by using shell script we will create storage account in another resource group

#Terraform State File
# Terraform uses the state file as the source of truth and reconciles differences between
# desired configuration and actual infrastructure during plan and apply operations.
#Terraform state should always be stored in a remote backend to ensure consistency, security, and collaboration.
#Terraform state files should never be manually modified; all state changes must be performed using
# Terraform commands to avoid corruption.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.49"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "learning-tf-rg"
    storage_account_name = "azdevops12574"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}


provider "azurerm" {
  features {}
  subscription_id = "af504235-2f6d-4469-aa25-251f498730fc"
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