resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  upper   = false
  special = false
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.internal_port
    external = var.external_port[count.index]
  }
  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol" # path.cwd with string interpolation will provide the full path for the current directory.
  }
}