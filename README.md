# Azure Dev VM

A module which creates a VM in Azure with a set of configurable dev tools installed.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.dev_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.dev_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.dev_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_role_assignment.dev_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_user_to_groups"></a> [add\_user\_to\_groups](#input\_add\_user\_to\_groups) | A list of linux groups to add the default user to | `list(string)` | `[]` | no |
| <a name="input_install_apt_packages"></a> [install\_apt\_packages](#input\_install\_apt\_packages) | A list of apt packages to install on the VM | <pre>list(<br>    object(<br>      {<br>        name = string,<br>        repository = optional(object({<br>          source : string<br>          keyid : string<br>          keyserver : optional(string)<br>        }))<br>      }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_install_sdkman"></a> [install\_sdkman](#input\_install\_sdkman) | Whether to install sdkman (must have zip and unzip installed) | `bool` | `false` | no |
| <a name="input_install_sdkman_packages"></a> [install\_sdkman\_packages](#input\_install\_sdkman\_packages) | A list of sdkman tool to install (requires install\_sdkman to be true; version\_regex is a grep format regex) | <pre>list(object({<br>    name          = string,<br>    version_regex = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location to create the VM in | `string` | n/a | yes |
| <a name="input_log_in_to_first_acr"></a> [log\_in\_to\_first\_acr](#input\_log\_in\_to\_first\_acr) | Causes docker to log in to the first ACR registry in the VMs resource group (requires docker to be installed) | `bool` | `false` | no |
| <a name="input_log_in_to_first_aks_cluster"></a> [log\_in\_to\_first\_aks\_cluster](#input\_log\_in\_to\_first\_aks\_cluster) | Causes kubectl to log in to the first AKS cluster in the VMs resource group (requires kubectl to be installed) | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the VM (used in the name of all resource created) | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Azure resource group to create the VM in | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public SSH key used to connect to the VM | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet to attach the VM to. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The default user on the VM | `string` | `"adminuser"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_template"></a> [template](#output\_template) | n/a |
<!-- END_TF_DOCS -->
