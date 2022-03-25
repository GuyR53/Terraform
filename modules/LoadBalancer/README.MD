<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 2.65 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.LoadBalancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.BackendAdrress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool_address.Application1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_backend_address_pool_address.Application2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_backend_address_pool_address.Application3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_probe.ProbeA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.RuleA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_public_ip.LoadBalancerIP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_LoadbalancersubnetID"></a> [LoadbalancersubnetID](#input\_LoadbalancersubnetID) | Load balancer subnetID | `any` | n/a | yes |
| <a name="input_VirtualNetworkID"></a> [VirtualNetworkID](#input\_VirtualNetworkID) | Virtual network ID | `any` | n/a | yes |
| <a name="input_my_region"></a> [my\_region](#input\_my\_region) | Value of the region I use | `string` | `"eastus"` | no |
| <a name="input_privateipaddrres1"></a> [privateipaddrres1](#input\_privateipaddrres1) | The privateIP for the virtual machine that is first in the list | `any` | n/a | yes |
| <a name="input_privateipaddrres2"></a> [privateipaddrres2](#input\_privateipaddrres2) | The privateIP for the virtual machine that is second in the list | `any` | n/a | yes |
| <a name="input_privateipaddrres3"></a> [privateipaddrres3](#input\_privateipaddrres3) | The privateIP for the virtual machine that is third in the list | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"LoadBalancer"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->