rg_name  = "learning-rg-dev"
location = "UK West"

vnet_name     = "dev-vnet"
address_space = ["10.0.0.0/16"]
subnet_name   = "dev-subnet"
subnet_prefix = ["10.0.1.0/24"]

vm_name        = "rhel-vm-dev"
vm_size        = "Standard_D2s_v3"
admin_username = "azureuser"
admin_password = "azureuser@123"
nic_name       = "dev-vm-nic"
public_ip_name = "dev-vm-pip"