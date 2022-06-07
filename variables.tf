variable "container_count" {
  type    = number
  default = 4
}

variable "internal_port" {
  type = number

  validation {
    condition     = var.internal_port == 1880
    error_message = "The internal port must be 1880."
  }
}

variable "external_port" {
  type = list(any)

  validation {
    condition     = max(var.external_port...) <= 65535 && min(var.external_port...) > 0 # "..." is a spread operator when we use lists.
    error_message = "The external port must be in the valid port range 0 - 65535."
  }
}

