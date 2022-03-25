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
| [azurerm_linux_virtual_machine.myterraformvm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.myterraformnic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AppSubnetID"></a> [AppSubnetID](#input\_AppSubnetID) | Application subnetID | `any` | n/a | yes |
| <a name="input_my_region"></a> [my\_region](#input\_my\_region) | Value of the region I use | `string` | `"eastus"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"AppServer"` | no |
| <a name="input_vm_names"></a> [vm\_names](#input\_vm\_names) | List of machines to create with their names | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Password"></a> [Password](#output\_Password) | n/a |
| <a name="output_networkinterfaceprivateipadrress1"></a> [networkinterfaceprivateipadrress1](#output\_networkinterfaceprivateipadrress1) | n/a |
| <a name="output_networkinterfaceprivateipadrress2"></a> [networkinterfaceprivateipadrress2](#output\_networkinterfaceprivateipadrress2) | n/a |
| <a name="output_networkinterfaceprivateipadrress3"></a> [networkinterfaceprivateipadrress3](#output\_networkinterfaceprivateipadrress3) | n/a |
<!-- END_TF_DOCS -->