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

variable "vsphere_host" {
  description = "Host name on the vSphere server."
  default     = "virttest-05.calenglab.spirentcom.com"
}

variable "instance_count" {
  description = "Number of STCv instances to create."
  type        = number
  default     = 1
}

variable "num_cpus" {
  description = "The total number of virtual processor cores to assign to STCv virtual machine"
  default     = "2"
}

variable "memory" {
  description = "The size of the virtual machine's memory, in MB."
  default     = "2048"
}

variable "template_name" {
  description = "Name of the template created from the OVF or OVA"
  default     = "aion_template"
}

variable "mgmt_plane_subnet_id" {
  description = "Management network ID."
  default     = ""
}

variable "aion_url" {
  description = "AION URL."
  default     = "https://spirent.spirentaion.com"
}

variable "aion_user" {
  description = "AION user. Specify using command line or env variables."
}

variable "aion_password" {
  description = "AION password. Specify using command line or env variables."
}

variable "admin_password" {
  description = "New cluster admin password. Specify using command line or env variables."
}