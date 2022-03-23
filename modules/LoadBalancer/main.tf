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

resource "azurerm_public_ip" "LoadBalancerIP" {
   name                         = "publicIPForLB"
   location                     = var.my_region
   resource_group_name          = var.resource_group_name
   allocation_method            = "Static"
   depends_on = [azurerm_resource_group.rg]
 }

resource "azurerm_lb" "LoadBalancer" {
   name                = "loadBalancer"
   location            = var.my_region
   resource_group_name = var.resource_group_name
   depends_on = [azurerm_resource_group.rg]

   frontend_ip_configuration {
     name                 = "publicIPAddress"
     public_ip_address_id = azurerm_public_ip.LoadBalancerIP.id
   }
 }

resource "azurerm_lb_backend_address_pool" "backendaddress" {
   loadbalancer_id     = azurerm_lb.LoadBalancer.id
   name                = "BackEndAddressPool"
 }

#resource "azurerm_availability_set" "avset" {
#   name                         = "avset"
#   location                     = var.my_region
#   resource_group_name          = var.resource_group_name
#   platform_fault_domain_count  = 3
#   platform_update_domain_count = 3
#   managed                      = true
# }
