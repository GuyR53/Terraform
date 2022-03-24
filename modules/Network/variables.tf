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

variable "privateipaddrres1" {}

variable "privateipaddrres2" {}

variable "privateipaddrres3" {}