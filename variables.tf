variable "container_count" {
  type = number
}

variable "internal_port" {
  type        = number

  validation {
    condition = var.internal_port == 1880
    error_message = "The internal port must be 1880."
  }
}

variable "external_port" {
  type        = number

  validation {
    condition = var.external_port <= 65535 && var.external_port > 0
    error_message = "The external port must be in the valid port range 0 - 65535."
  }
}

