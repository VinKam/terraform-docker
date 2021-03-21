resource "random_string" "container" {
  count = var.count_in
  length = 4
  special = false
}

resource "docker_container" "container" {
  count = var.count_in
  name =  join("-", [var.name_in, random_string.container[count.index].result])
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.container_path_in
    content {
    container_path = volumes.value
    volume_name = module.volumes[count.index].volumes_out[volumes.key]
   }
  }
  provisioner "local-exec" {
    command = "echo ${self.name} - ${self.ip_address}:${self.ports[0].external} >> infoworld"
  }
}

  module "volumes" {
    source = "./volumes"
    count = var.count_in
    volumes_in = length(var.container_path_in)
    name_in = "${var.name_in}-${terraform.workspace}-${random_string.container[count.index].result}-volume" 
 }

