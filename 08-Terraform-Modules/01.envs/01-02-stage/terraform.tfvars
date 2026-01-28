rg_name  = "learning-rg-stage"
location = "UK West"

vnet_name     = "stage-vnet"
address_space = ["10.10.0.0/16"]
subnet_name   = "stage-subnet"
subnet_prefix = ["10.10.1.0/24"]

vm_name        = "rhel-vm-stage"
vm_size        = "Standard_D2s_v3"
admin_username = "azureuser"
admin_password = "azureuser@123"
nic_name       = "stage-vm-nic"
public_ip_name = "stage-vm-pip"
