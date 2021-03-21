#output "containers" {
#  value = module.nodered_container[*].containers
#}

#output "ip_ports" {
#  value = module.nodered_container[*].ip_ports
#}

output "containers" {
  value = module.nodered_container[*]
}
