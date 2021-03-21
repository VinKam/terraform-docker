#output "containers" {
#  value = docker_container.nodered.name
#}

#output "ip_ports" {
#  value = [for i in docker_container.nodered[*]: join(":", [i.ip_address], i.ports[*].external)]
#}

#output "ip_ports" {
#  value = join(":", [docker_container.nodered.ip_address], docker_container.nodered.ports[*].external)
#}

output "app_containers" {
  value = { for x in docker_container.container[*]: x.name => join (":", [x.ip_address], x.ports[*]["external"])}
}
