output template {
    value = templatefile(
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
  )
}