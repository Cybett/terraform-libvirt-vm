output "instance_names" {
  description = "Names of the created VM instances"
  value       = libvirt_domain.vm_instance[*].name
}

output "instance_ips" {
  description = "IP addresses of the created VM instances"
  value       = libvirt_domain.vm_instance[*].network_interface[*].addresses
}
