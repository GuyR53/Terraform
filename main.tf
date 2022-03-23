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

module "Network" {
  source = "./modules/Network"
}

module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  vm_names = ["ApplicationServer-1", "ApplicationServer-2","ApplicationServer-3"]
  AppSubnetID = module.Network.AppSubnet
  NetworkSecurityGroupID = module.Network.SecurityGroupID
}

module "LoadBalancer" {
  source = "./modules/LoadBalancer"
}




