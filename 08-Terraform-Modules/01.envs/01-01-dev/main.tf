module "rg" {
  source   = "../../02.modules/02-01-resource-group"
  rg_name  = "learning-rg-dev"
  location = "UK West"
}

module "network" {
  source        = "../../02.modules/02-02-network"
  rg_name       = module.rg.rg_name
  location      = module.rg.location
  vnet_name     = "dev-vnet"
  address_space = ["10.0.0.0/16"]
  subnet_name   = "dev-subnet"
  subnet_prefix = ["10.0.1.0/24"]
}

module "compute" {
  source         = "../../02.modules/02-03-compute"
  rg_name        = module.rg.rg_name
  location       = module.rg.location
  subnet_id      = module.network.subnet_id
  vm_name        = "rhel-vm-dev"
  vm_size        = "Standard_D2s_v3"
  admin_username = "azureuser"
  admin_password = "azureuser@123"
  nic_name       = "dev-vm-nic"
  public_ip_name = "dev-vm-pip"
}
