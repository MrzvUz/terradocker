locals {
  deployment = {
    nodered = {
      container_count = length(var.external_port["nodered"][terraform.workspace])
      image           = var.image["nodered"][terraform.workspace]
      internal        = 1880
      external        = var.external_port["nodered"][terraform.workspace]
      container_path  = "/data"
    }
    influxdb = {
      container_count = length(var.external_port["influxdb"][terraform.workspace])
      image           = var.image["influxdb"][terraform.workspace]
      internal        = 8086
      external        = var.external_port["influxdb"][terraform.workspace]
      container_path  = "/var/lib/influxdb"
    }
    grafana = {
      container_count = length(var.external_port["grafana"][terraform.workspace])
      image           = var.image["grafana"][terraform.workspace]
      internal        = 3000
      external        = var.external_port["grafana"][terraform.workspace]
      container_path  = "/var/lib/grafana"
    }
  }
}
