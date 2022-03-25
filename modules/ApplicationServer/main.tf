
# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.my_region
     tags = {
    type = "VirtualMachineRelated"
  }
}





# Public IP for the configuration machine only
resource "azurerm_public_ip" "public_ip" {
  name                = "ConfigurationMachine"
  resource_group_name = var.resource_group_name
  location            = var.my_region
  allocation_method   = "Static"
  depends_on = [azurerm_resource_group.rg]

}

# Resources for each virtual machines:
# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  count = length(var.vm_names)
  name                = "myNIC-${var.vm_names[count.index]}"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg,azurerm_public_ip.public_ip]



  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = var.AppSubnetID
    private_ip_address_allocation = "Dynamic"
    # PublicIP only for the configuration machine (the last machine on the list)
    public_ip_address_id = count.index == local.MachinewithIP ? azurerm_public_ip.public_ip.id : null

  }

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









