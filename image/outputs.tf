# ./image/outputs.tf
output "image_output" {
  value = docker_image.nodered_image.latest
}