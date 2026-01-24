# variable "environment" {
#   type        = string
#   description = "Environment name"
#   default     = "Dev"
# }
# variable "allowed_locations" {
#   type        = list(string)
#   description = "Allowed Azure locations"
#   default     = ["UK West", "North Europe", "East US"]
# }
#
# variable "resource_group_name" {
#   type        = string
#   description = "Resource group name"
#   default     = "learning-resources"
# }
#
# #for Hard coding values
# variable "storage_account_name" {
#   type = string
#   default = "azdevopsvenkat"
# }
#
# # # For using dynamic
# # variable "storage_account_name" {
# #   type = list(string)
# #   default = ["azdevopsvenkat", "azdevopsvenkat1", "azdevopsvenkat2"]
# # }