# Use a Terraform backend to store the Terraform state in Azure Blob Storage
terraform {
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate21774"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}