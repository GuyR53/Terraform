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

module "VirtualMachines" {
  source = "./modules/ApplicationServer"

}

module "LoadBalancer" {
  source = "./modules/LoadBalancer"
}




