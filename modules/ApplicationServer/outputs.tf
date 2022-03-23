output "Password" {
  value = azurerm_linux_virtual_machine.myterraformvm[0].admin_password
}