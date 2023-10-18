terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  location = "UK South"
  name     = "resource-group"
}

resource "azurerm_virtual_network" "main" {
  address_space       = ["10.52.0.0/16"]
  location            = "UK South"
  name                = "network"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  address_prefixes                          = ["10.52.0.0/24"]
  name                                      = "subnet"
  resource_group_name                       = azurerm_resource_group.main.name
  virtual_network_name                      = azurerm_virtual_network.main.name
  private_endpoint_network_policies_enabled = true
}

module "dev_vm" {
  source = "../../"

  name                = "dev-vm"
  location            = "UK South"
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.main.id
  ssh_public_key      = chomp(file("~/.ssh/id_rsa.pub"))

  add_user_to_groups = ["docker"]

  install_apt_packages = [
    { name = "docker.io" },
    { name = "git" },
    { name = "unzip" },
    { name = "zip" }
  ]

  install_sdkman = true
  install_sdkman_packages = [
    { name = "java", version_regex = "17\\.[0-9]*\\.[0-9]*\\-tem" },
    { name = "sbt" }
  ]
}