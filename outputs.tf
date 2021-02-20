# OUTPUTS
output "instance_uuids" {
  description = "List of UUIDs assigned to the instances."
  value       = vsphere_virtual_machine.aion.*.id
}
