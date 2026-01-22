variable "environment" {
  type        = string
  description = "Environment name"
  default     = "Dev"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "learning-resources"
}

variable "allowed_locations" {
  type        = list(string)
  description = "Allowed Azure locations"
  default     = ["UK West", "North Europe", "East US"]
}

variable "storage_disk" {
  type        = number
  description = "OS disk size in GB"
  default     = 80
}

variable "is_delete" {
  type        = bool
  description = "Delete OS disk on VM termination"
  default     = true
}

variable "resource_tags" {
  type        = map(string)
  description = "Common resource tags"
  default = {
    environment = "staging"
    managed_by  = "terraform"
    department  = "devops"
  }
}

variable "network_config" {
  type        = tuple([string, string, number])
  description = "VNET CIDR, Subnet CIDR, Subnet Mask"
  default     = ["10.0.0.0/16", "10.0.2.0", 24]
}

variable "allowed_vm_sizes" {
  type        = list(string)
  description = "Allowed VM sizes"
  default     = ["Standard_DS2_v3", "Standard_DS2_v2", "Standard_DS3_v2"]
}

variable "vm_config" {
  type = object({
    size      = string
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    size      = "Standard_D2s_v5"   # RHEL needs more CPU/RAM
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "94_gen2"
    version   = "latest"
  }
}
