module "rg" {
  source   = "../../02.modules/02-01-resource-group"
  rg_name  = "learning-rg-prod"
  location = "UK West"
}

module "network" {
  source        = "../../02.modules/02-02-network"
  rg_name       = module.rg.rg_name
  location      = module.rg.location
  vnet_name     = "prod-vnet"
  address_space = ["10.20.0.0/16"]
  subnet_name   = "prod-subnet"
  subnet_prefix = ["10.20.1.0/24"]
}

module "compute" {
  source         = "../../02.modules/02-03-compute"
  rg_name        = module.rg.rg_name
  location       = module.rg.location
  subnet_id      = module.network.subnet_id
  vm_name        = "rhel-vm-prod"
  vm_size        = "Standard_D4s_v3"   # Bigger VM for prod
  admin_username = "azureuser"
  admin_password = "azureuser@123"
  nic_name       = "prod-vm-nic"
  public_ip_name = "prod-vm-pip"
}
