variable "vsphere_server" {
  description = "The vSphere server."
  default     = "vsphere.spirentcom.com"
}

variable "vsphere_user" {
  description = "The user to access vSphere."
  default     = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "The password for the current vSphere user."
  default     = "VspherePassword"
}

variable "vsphere_datacenter" {
  description = "The name of the vSphere Datacenter into which resources will be created."
  default     = "dc"
}

variable "vsphere_datastore" {
  description = "The name of the vSphere Datastore into which resources will be created."
  default     = "ds"
}

variable "vsphere_compute_cluster" {
  description = "The vSphere Cluster into which resources will be created."
  default     = "cluster1"
}

variable "vsphere_host" {
  description = "Host name on the vSphere server."
  default     = "vsphere-01.spirentcom.com"
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

variable "mgmt_plane_network" {
  description = "Management network name."
  default     = "Host Network"
}

variable "mac_address_list" {
  description = "MAC address list."
  type        = list(string)
  default     = ["00:00:00:11:22:33"]
}

variable "ip_address_list" {
  description = "IPv4 address list."
  type        = list(string)
  default     = ["10.0.0.11"]
}

variable "ip_netmask" {
  description = "IPv4 netmask."
  type        = string
  default     = "255.255.255.0"
}

variable "ip_gateway" {
  description = "IPv4 gateway address."
  type        = string
  default     = "10.0.0.1"
}

variable "private_key_file" {
  description = "SSH private key file"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "public_key_file" {
  description = "SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "iso_dest" {
  description = "ISO destination directory"
  default     = "aion_iso"
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
