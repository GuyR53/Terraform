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
  default = ["ApplicationServer-1", "ApplicationServer-2","ApplicationServer-3"]
}

locals  {
  count = length(var.vm_names)
}