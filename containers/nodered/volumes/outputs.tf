output "volumes_out" {
 value = docker_volume.container[*].name
}
