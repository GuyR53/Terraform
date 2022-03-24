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
}
variable "AppSubnetID" {

}

variable "NetworkSecurityGroupID" {

}