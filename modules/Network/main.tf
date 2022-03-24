

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

# Create network security group for app servers
resource "azurerm_network_security_group" "AppServer" {
  name                = "myNetworkSecurityGroupApp"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg,azurerm_subnet.myterraformsubnet]

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
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the app network security group to the app subnet
resource "azurerm_subnet_network_security_group_association" "NSGconnectiontosubnetApp" {
  subnet_id                 = azurerm_subnet.myterraformsubnet.id
  network_security_group_id = azurerm_network_security_group.AppServer.id
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

# Create network security group for db server
resource "azurerm_network_security_group" "DBServer" {
  name                = "myNetworkSecurityGroupDB"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg,azurerm_subnet.myterraformsubnet2]

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.privateipaddrres1
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "Port_5432_App1"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.privateipaddrres1
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Port_5432_App2"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.privateipaddrres2
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Port_5432_App3"
    priority                   = 330
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.privateipaddrres3
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyVnetInBound"
    priority                   = 340
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }


}

# Connect the db network security group to the db subnet
resource "azurerm_subnet_network_security_group_association" "NSGconnectiontosubnetDB" {
  subnet_id                 = azurerm_subnet.myterraformsubnet2.id
  network_security_group_id = azurerm_network_security_group.DBServer.id
}


