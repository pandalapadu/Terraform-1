# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 4.49"
#     }
#   }
# }
#
# provider "azurerm" {
#   features {}
#   subscription_id = "af504235-2f6d-4469-aa25-251f498730fc"
# }
#
# resource "azurerm_resource_group" "rg" {
#   name     = "learning-resources"
#   location = "UK West"
# }
#
# resource "azurerm_storage_account" "storage_account" {
# # depends_on = [ azurerm_resource_group.rg ]
#   name                     = "azdevopsvenkat"
#   resource_group_name      = azurerm_resource_group.rg.name  # implicit dependency
#   location                 = azurerm_resource_group.rg.location # implicit dependency
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#
#   tags = {
#     environment = "Dev"
#   }
# }

##===========================
##if we need to configure Explicit dependency we pass dependency [] specifically on each resource .
# depends_on = [ azurerm_resource_group.rg ]
##if you delete/comment storage resource it will validate the state file whether resource is there or not if not it will be destroyed
#and make it only resource group