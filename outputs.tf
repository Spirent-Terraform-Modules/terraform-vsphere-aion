# OUTPUTS
output "instance_uuids" {
  description = "List of UUIDs assigned to the instances."
  value       = vsphere_virtual_machine.aion.*.id
}

output "instance_default_ips" {
  description = "List of default IP addresses assigned to the instances, if applicable."
  value       = vsphere_virtual_machine.aion.*.default_ip_address
}

output "instance_guest_ips" {
  description = "List of guest IP addresses assigned to the instances, if applicable."
  value       = vsphere_virtual_machine.aion.*.guest_ip_addresses
}