resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

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

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image = module.image.image_output
  ports {
    internal = var.internal_port
    external = var.external_port[terraform.workspace][count.index] # terraform.workspace map key auto deploys on current environment.
  }
  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol" # path.cwd with string interpolation will provide the full path for the current directory.
  }
}