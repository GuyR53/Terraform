terraform {
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate21774"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}