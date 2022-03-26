<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AppSubnetID"></a> [AppSubnetID](#input\_AppSubnetID) | Application subnetID | `any` | n/a | yes |
| <a name="input_lb_backend_address_pool_id"></a> [lb\_backend\_address\_pool\_id](#input\_lb\_backend\_address\_pool\_id) | Load Balancer address pool ID for vmss | `any` | n/a | yes |
| <a name="input_my_region"></a> [my\_region](#input\_my\_region) | Value of the region I use | `string` | `"eastus"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"ScaleSet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_VMSS_Password"></a> [VMSS\_Password](#output\_VMSS\_Password) | n/a |
<!-- END_TF_DOCS -->