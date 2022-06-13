output "ip_address" {
  value       = flatten(module.container[*].ip_address) # flatten function puts the list into one line.
  description = "The IP address and external port of the container"
}

output "container_name" {
  value       = module.container[*].container_name
  description = "The name of the container"
}