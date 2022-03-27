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
| [azurerm_postgresql_flexible_server.guy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_private_dns_zone.guy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.guy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DBSubnet"></a> [DBSubnet](#input\_DBSubnet) | Database subnetID (private subnet) | `any` | n/a | yes |
| <a name="input_Password"></a> [Password](#input\_Password) | Password for db | `string` | `""` | no |
| <a name="input_VirtualNetworkID"></a> [VirtualNetworkID](#input\_VirtualNetworkID) | Virtual network ID | `any` | n/a | yes |
| <a name="input_my_region"></a> [my\_region](#input\_my\_region) | Value of the region I use | `string` | `"eastus"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"ManagedDB"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->