locals {
  container_count = length(var.external_port[terraform.workspace]) # terraform.workspace map key auto deploys on current environment.
}
