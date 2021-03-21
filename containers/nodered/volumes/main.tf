resource "docker_volume" "container" {
  count = var.volumes_in
  name = "${var.name_in}-${count.index}"
  
  provisioner "local-exec" {
    when = destroy
    command = "mkdir -p ${path.cwd}/backup/${self.name}"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rsync -avzp ${self.mountpoint}/ ${path.cwd}/backup/${self.name}/"
  }
}

