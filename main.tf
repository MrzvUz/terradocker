resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count   = 1
  length  = 4
  upper   = false
  special = false
}

resource "docker_container" "nodered_container" {
  count = 1
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.internal_port
    # external = var.external_port
  }
}

output "ip_address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "The IP address and external port of the container"
}

output "container_name" {
  value       = docker_container.nodered_container[*].name
  description = "The name of the container"
}