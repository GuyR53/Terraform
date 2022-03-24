output "Password" {
  value = azurerm_linux_virtual_machine.myterraformvm[0].admin_password
}

output "networkinterfaceprivateipadrress1" {
  value = azurerm_network_interface.myterraformnic[0].private_ip_address
}

output "networkinterfaceprivateipadrress2" {
  value = azurerm_network_interface.myterraformnic[1].private_ip_address
}


output "networkinterfaceprivateipadrress3" {
  value = azurerm_network_interface.myterraformnic[2].private_ip_address
}