module "image" {
  source   = "./image"
  image_in = var.image[terraform.workspace]
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  upper   = false
  special = false
}

module "container" {
  source            = "./container"
  count             = local.container_count
  name_in           = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image_in          = module.image.image_out
  int_port_in       = var.internal_port
  ext_port_in       = var.external_port[terraform.workspace][count.index] # terraform.workspace map key auto deploys on current environment.
  container_path_in = "/data"
  host_path_in      = "${path.cwd}/noderedvol" # path.cwd with string interpolation will provide the full path for the current directory.
}