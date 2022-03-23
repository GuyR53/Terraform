output "AppSubnet" {
  value = azurerm_subnet.myterraformsubnet.id
}

output "DBSubnet" {
  value = azurerm_subnet.myterraformsubnet2.id
}

output "SecurityGroupID" {
  value = azurerm_network_security_group.AppServer.id
}

output "NetworkID" {
  value = azurerm_virtual_network.VNet.id
}