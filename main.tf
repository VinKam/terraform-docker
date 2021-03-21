locals {
  deployment = {
    nodered = {
      container_path = ["/data"]
    }
    influxdb = {
      container_path = ["/var/lib/influxdb"]
    }
    grafana = {
      container_path = ["/var/lib/grafana", "/etc/grafana"]
    }
  }
}


module "images" {
  for_each = var.images
  source = "./images"
  image_in = var.images[each.key][terraform.workspace]
}


module "nodered_container" {
  source = "./containers/nodered"
  for_each = local.deployment
  count_in = length(var.external_port[each.key][terraform.workspace])
#  name_in = join("-", ["${each.key}-vk", random_string.container[each.key].result])
  name_in = each.key
  image_in = module.images[each.key].image_out
  int_port_in = var.internal_port[each.key]
  ext_port_in = var.external_port[each.key][terraform.workspace]
  container_path_in = each.value.container_path  
}

