resource "azurerm_public_ip" "dev_vm" {
  name                = "${var.name}-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "dev_vm" {
  name                = "${var.name}-dev-vm"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "network"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev_vm.id
  }
}

resource "azurerm_linux_virtual_machine" "dev_vm" {
  name                = "${var.name}-dev-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.dev_vm.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = var.ssh_public_key
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile(
    "${path.module}/cloud-init.yml.tftpl",
    {
      username                    = var.username,
      add_user_to_groups          = var.add_user_to_groups,
      install_apt_packages        = var.install_apt_packages
      install_sdkman              = var.install_sdkman
      install_sdkman_packages     = var.install_sdkman_packages
      log_in_to_first_aks_cluster = var.log_in_to_first_aks_cluster,
      log_in_to_first_acr         = var.log_in_to_first_acr
    }
  ))
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "dev_vm" {
  principal_id         = azurerm_linux_virtual_machine.dev_vm.identity[0].principal_id
  role_definition_name = var.role_definition_name
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
}