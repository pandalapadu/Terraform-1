output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vm_name" {
  value = azurerm_virtual_machine.main.name
}

output "vm_private_ip" {
  value = azurerm_network_interface.main.private_ip_address
}
