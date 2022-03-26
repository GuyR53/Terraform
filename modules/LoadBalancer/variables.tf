variable "resource_group_name" {
  default = "LoadBalancer"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}

variable "LoadbalancersubnetID" {
  description = "Load balancer subnetID"

}
variable "VirtualNetworkID" {
  description = "Virtual network ID"
}

#variable "ScaleSetPrivateIP" {
#  description = "Scale Set PrivateIP for backend pool"
#}