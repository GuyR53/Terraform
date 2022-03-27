# TerraformWeek5

### Run the infrastructure from the root module which will use the sub modules.

### You can use *.tfvars file with variable Password to run it.




<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_LoadBalancer"></a> [LoadBalancer](#module\_LoadBalancer) | ./modules/LoadBalancer | n/a |
| <a name="module_ManagedDB"></a> [ManagedDB](#module\_ManagedDB) | ./modules/ManagedDB | n/a |
| <a name="module_Network"></a> [Network](#module\_Network) | ./modules/Network | n/a |
| <a name="module_VirtualMachines"></a> [VirtualMachines](#module\_VirtualMachines) | ./modules/ApplicationServer | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_my_region"></a> [my\_region](#input\_my\_region) | Value of the region I use | `string` | `"eastus"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Password"></a> [Password](#output\_Password) | n/a |
<!-- END_TF_DOCS -->
