

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

# Create subnet for app
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [azurerm_resource_group.rg]
}

# Create subnet for db
resource "azurerm_subnet" "myterraformsubnet2" {
  name                 = "private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
   delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }



  depends_on = [azurerm_resource_group.rg]
}

# Create subnet for vmss
resource "azurerm_subnet" "vmss" {
 name                 = "vmss-subnet"
 resource_group_name  = var.resource_group_name
 virtual_network_name = azurerm_virtual_network.VNet.name
 address_prefixes       = ["10.0.2.0/24"]
}

# Create network security group for app server
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