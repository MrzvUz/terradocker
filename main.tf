resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && chown -R 1000:1000 noderedvol/"
  }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count   = var.container_count
  length  = 4
  upper   = false
  special = false
}

resource "docker_container" "nodered_container" {
  count = var.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.internal_port
    external = var.external_port
  }
  volumes {
    container_path = "/data"
    host_path = "/Users/akhmatali_mirzaev/Documents/Projects/terradocker/noderedvol"
  }
}