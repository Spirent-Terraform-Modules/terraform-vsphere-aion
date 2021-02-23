## Example : This Terraform module deploys Spirent TestCenter Virtual Machines from OVF template.
# The example requires the user to provide an already existing datacenter , datastore, network , OVF template details .

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "aion" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "aion" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.aion.id
}

data "vsphere_compute_cluster" "aion" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.aion.id
}

data "vsphere_network" "mgmt_plane" {
  name          = var.mgmt_plane_network
  datacenter_id = data.vsphere_datacenter.aion.id
}

module "aion" {
  source                = "../.."
  instance_count        = var.instance_count
  num_cpus              = var.num_cpus
  memory                = var.memory
  datacenter            = data.vsphere_datacenter.aion.name
  datastore             = data.vsphere_datastore.aion.name
  resource_pool_id      = data.vsphere_compute_cluster.aion.resource_pool_id
  mgmt_plane_network_id = data.vsphere_network.mgmt_plane.id
  template_name         = var.template_name
  aion_url              = var.aion_url
  aion_user             = var.aion_user
  aion_password         = var.aion_password
  admin_password        = var.admin_password
  ips                   = var.ips
  ip_netmask            = var.ip_netmask
  ip_gateway            = var.ip_gateway
  macs                  = var.macs
  public_key_file       = var.public_key_file
  private_key_file      = var.private_key_file
  iso_dest              = var.iso_dest
}

output "instance_uuids" {
  description = "List of UUIDs assigned to the instances, if applicable."
  value       = module.aion.*.instance_uuids
}
