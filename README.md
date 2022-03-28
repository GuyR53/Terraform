# TerraformWeek5

## Goal:

<img width="542" alt="Screen Shot 2022-03-28 at 11 54 09" src="https://user-images.githubusercontent.com/93793111/160362958-ad89d339-d94d-4fce-995e-891e3160b7e6.png">

### 1. Use Terraform to define all the infrastructure.
### 2. Create a terraform module to reuse the code that creat
### 3. Ensure the application is up and running (and work automatically after reboot).
### 4. Ensure the Network Security Group (NSG) allows to access the servers and allows communication between the web server and the database.
### 5. Make sure the database cannot be accessed from the internet (it’s not publicly exposed).
### 6. Make the solution elastic by using Virtual Machine Scale Sets.
### 7. Ensure that the solution is High Available by using multiple application servers (as shown in the diagram above)
### 8. Use the Azure PostgreSQL managed Service
### 9. Use a Terraform backend to store the Terraform state in Azure Blob Storage



## How to run

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
| <a name="module_ScaleSet"></a> [ScaleSet](#module\_ScaleSet) | ./modules/ScaleSet | n/a |
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
