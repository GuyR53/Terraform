output "AppSubnet" {
  value = azurerm_subnet.myterraformsubnet.id
}

output "SecurityGroupID" {
  value = azurerm_network_security_group.AppServer.id
}