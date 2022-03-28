variable "resource_group_name" {
  default = "AppServer"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}

variable "vm_names" {
  type = list
  description = "List of machines to create with their names"
}
variable "AppSubnetID" {
    description = "Application subnetID"
}

variable "Password" {
  type = string
  description = "Password for vm"
  default = "ItsNotTheRealPassword!123"

}


# Getting the index of the configuration machine to make publicIPAddress
locals {
  MachinewithIP="${length(var.vm_names)-1}"
}

