
# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.my_region
}



# Resources for each virtual machine:




# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  count = length(var.vm_names)
  name                = "myNIC-${var.vm_names[count.index]}"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg]



  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = var.AppSubnetID
    private_ip_address_allocation = "Dynamic"

  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "Connected2" {
  count = length(var.vm_names)
  network_interface_id      = azurerm_network_interface.myterraformnic[count.index].id
  network_security_group_id = var.NetworkSecurityGroupID
  depends_on = [azurerm_network_interface.myterraformnic]
}


# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  count = length(var.vm_names)
  name                  = "${var.vm_names[count.index]}"
  location              = var.my_region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.myterraformnic[count.index].id]
  size                  = "Standard_DS2_v2"
  depends_on = [azurerm_network_interface.myterraformnic]


  os_disk {
    name                 = "Disk-${var.vm_names[count.index]}"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "${var.vm_names[count.index]}"
  disable_password_authentication = false
  admin_password = file("${path.module}/password.txt")


}