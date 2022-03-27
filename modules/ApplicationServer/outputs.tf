output "SSHMachineToDB" {
  value = azurerm_network_interface.myterraformnic[0].private_ip_address
}
