# terraform {
#   backend "azurerm" {
#     resource_group_name  = "learning-tf-rg"
#     storage_account_name = "azdevops18692"
#     container_name       = "tfstate"
#     key                  = "dev.tfstate"
#   }
# }