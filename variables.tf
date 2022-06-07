variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "container_count" {
  type    = number
  default = 4
}

variable "internal_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.internal_port == 1880
    error_message = "The internal port must be 1880."
  }
}

variable "external_port" {
  type = map(any)

  validation {
    condition     = max(var.external_port["dev"]...) <= 65535 && min(var.external_port["dev"]...) >= 1980 # "..." is a spread operator when we use lists.
    error_message = "The external port for dev must be in the valid port range equal or less than 65535 and equal or greater than 1980."
  }

  validation {
    condition     = max(var.external_port["prod"]...) < 1980 && min(var.external_port["prod"]...) >= 1880 # "..." is a spread operator when we use lists.
    error_message = "The external port for prod must be in the valid port range less than 1980 and equal or greater than 1880."
  }
}

