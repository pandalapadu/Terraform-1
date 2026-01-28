rg_name  = "learning-rg-prod"
location = "UK West"

vnet_name     = "prod-vnet"
address_space = ["10.20.0.0/16"]
subnet_name   = "prod-subnet"
subnet_prefix = ["10.20.1.0/24"]

vm_name        = "rhel-vm-prod"
vm_size        = "Standard_D4s_v3"   # Bigger VM for production
admin_username = "azureuser"
admin_password = "azureuser@123"
nic_name       = "prod-vm-nic"
public_ip_name = "prod-vm-pip"
