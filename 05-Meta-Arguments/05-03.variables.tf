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

# ----- Dynamic Storage Accounts Variable (list of strings) -----
variable "dynamic_storage_accounts_list" {
  type    = list(string)
  default = [
    "listdynamicvenkat",
    "listdynamicvenkat1"
  ]
}