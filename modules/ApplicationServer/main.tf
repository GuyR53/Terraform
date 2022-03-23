# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}



# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.my_region
}

# Create a virtual network
resource "azurerm_virtual_network" "VNet" {
    name                = "GuyNet"
    address_space       = ["10.0.0.0/16"]
    location            = var.my_region
    resource_group_name = var.resource_group_name
    depends_on = [azurerm_resource_group.rg]
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [azurerm_resource_group.rg]
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet2" {
  name                 = "private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [azurerm_resource_group.rg]
}




resource "azurerm_network_security_group" "AppServer" {
  name                = "myNetworkSecurityGroup"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg]

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "79.180.53.74"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "Port_8080"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Resources for each virtual machine:


# Create public IPs
resource "azurerm_public_ip" "MyVMPublicIP2" {
  count = 3
  name                = "myPublicIP${count.index}"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  depends_on = [azurerm_resource_group.rg]
}
# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  count = 3
  name                = "myNIC${count.index}"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg]



  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.MyVMPublicIP2[count.index].id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "Connected2" {
  count = 3
  network_interface_id      = azurerm_network_interface.myterraformnic[count.index].id
  network_security_group_id = azurerm_network_security_group.AppServer.id
  depends_on = [azurerm_network_interface.myterraformnic,azurerm_network_security_group.AppServer]
}


# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  count = 3
  name                  = "ApplicationServer${count.index}"
  location              = var.my_region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.myterraformnic[count.index].id]
  size                  = "Standard_DS2_v2"
  depends_on = [azurerm_network_interface.myterraformnic]

  os_disk {
    name                 = "ApplicationServer${count.index}"
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
  admin_username                  = "azureuser"
  disable_password_authentication = false
  admin_password = "1234kdashdiwdS23@"


}