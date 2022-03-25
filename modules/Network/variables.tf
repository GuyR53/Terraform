variable "resource_group_name" {
  default = "Network"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}

variable "privateipaddrres1" {
   description = "The privateIP for the virtual machine that is first in the list"
}

variable "privateipaddrres2" {
  description = "The privateIP for the virtual machine that is second in the list"
}

variable "privateipaddrres3" {
  description = "The privateIP for the virtual machine that is third in the list"
}

