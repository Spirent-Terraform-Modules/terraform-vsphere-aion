## Example : This Terraform module deploys Spirent TestCenter Virtual Machines from OVF template.
# The example requires the user to provide an already existing datacenter , datastore, network , OVF template details .

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

variable "vsphere_server" {
  description = "The vSphere server."
  default     = "virttest-vc.calenglab.spirentcom.com"
}

variable "vsphere_user" {
  description = "The user to access vSphere."
  default     = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "The password for the current vSphere user."
  default     = "Sp!rent01"
}

variable "vsphere_datacenter" {
  description = "The name of the vSphere Datacenter into which resources will be created."
  default     = "Benchmarking"
}

variable "vsphere_datastore" {
  description = "The name of the vSphere Datastore into which resources will be created."
  default     = "VirtTest-05.local"
}

variable "vsphere_compute_cluster" {
  description = "The vSphere Cluster into which resources will be created."
  default     = "Testing"
}

data "vsphere_datacenter" "aion" {
  name          = var.vsphere_datacenter
}

data "vsphere_datastore" "aion" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.aion.id
}

output "datacenter" {
  value       = data.vsphere_datacenter.aion 
}

output "datastore" {
  value       = data.vsphere_datastore.aion 
}

