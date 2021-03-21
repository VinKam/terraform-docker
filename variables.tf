variable "internal_port" {
  type = map
  description = "internal port"
  default = {
    nodered = 1880
    influxdb = 1980
    grafana = 3000
   }
}

variable "images" {
  type = map
  description = "maps"
  default = {
    nodered = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
    influxdb = {
      dev = "influxdb:latest"
      prod = "influxdb:2.0.4"
    }
    grafana = {
      dev = "grafana/grafana:latest"
      prod = "grafana/grafana:7.4.2"
    }
  }
}


locals {
#  counts = length(lookup(var.external_port, terraform.workspace))
}

variable "external_port" {
  type = map
  description = "external port"
  default = {
    dev = [1880, 1881]
    prod = [1980, 1981]
  }

#  validation {
#    condition = max(var.external_port...) <= 65535 && min(var.external_port...) > 0
#    error_message = "Outside the range!." 
#  }
}
