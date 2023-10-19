variable "resource_group_name" {
  type        = string
  description = "The Azure resource group to create the VM in"
}

variable "location" {
  type        = string
  description = "The Azure location to create the VM in"
}

variable "name" {
  type        = string
  description = "The name of the VM (used in the name of all resource created)"
}

variable "size" {
  type        = string
  description = "The size of the VM"
  default     = "Standard_A4_v2"
}

variable "username" {
  type        = string
  description = "The default user on the VM"
  default     = "adminuser"
}

variable "add_user_to_groups" {
  type        = list(string)
  description = "A list of linux groups to add the default user to"
  default     = []
}

variable "ssh_public_key" {
  type        = string
  description = "The public SSH key used to connect to the VM"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to attach the VM to."
}

variable "install_apt_packages" {
  type = list(
    object(
      {
        name = string,
        repository = optional(object({
          source : string
          keyid : string
          keyserver : optional(string)
        }))
      }
    )
  )
  description = "A list of apt packages to install on the VM"
  default     = []
}

variable "install_sdkman" {
  type        = bool
  description = "Whether to install sdkman (must have zip and unzip installed)"
  default     = false
}

variable "install_sdkman_packages" {
  type = list(object({
    name          = string,
    version_regex = optional(string)
  }))
  description = "A list of sdkman tool to install (requires install_sdkman to be true; version_regex is a grep format regex)"
  default     = []
}

variable "log_in_to_first_aks_cluster" {
  type        = bool
  description = "Causes kubectl to log in to the first AKS cluster in the VMs resource group (requires kubectl to be installed)"
  default     = false
}

variable "log_in_to_first_acr" {
  type        = bool
  description = "Causes docker to log in to the first ACR registry in the VMs resource group (requires docker to be installed)"
  default     = false
}