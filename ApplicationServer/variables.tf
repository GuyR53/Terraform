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
  default = ["App1", "App2","App3"]
}

locals  {
  count = length(var.vm_names)
}