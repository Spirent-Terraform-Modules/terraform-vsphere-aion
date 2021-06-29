variable "vsphere_server" {
  description = "vSphere server"
  default     = "vsphere.spirentcom.com"
}

variable "vsphere_user" {
  description = "vSphere user name"
  default     = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "vSphere user password"
  default     = "VspherePassword"
}

variable "datacenter" {
  description = "vSphere datacenter name"
  default     = "dc"
}

variable "datastore" {
  description = "vSphere datastore name"
  default     = "ds"
}

variable "compute_cluster" {
  description = "vSphere Cluster name into which resources will be created"
  default     = "cluster1"
}

variable "instance_count" {
  description = "Number of AION instances to create"
  type        = number
  default     = 1
}

variable "num_cpus" {
  description = "Number of virtual processor cores assigned to an instance"
  default     = "4"
}

variable "memory" {
  description = "Size of the virtual machine's memory, in MB"
  default     = "32768"
}

variable "template_name" {
  description = "Name of the template created from the OVA"
  default     = "aion_template"
}

variable "mgmt_plane_network" {
  description = "Management network name"
  default     = "Host Network"
}

variable "macs" {
  description = "MAC address list.  Automatically set if not specified."
  type        = list(string)
  default     = ["00:00:00:11:22:33"]
}

variable "ips" {
  description = "Static IPv4 address list"
  type        = list(string)
  default     = ["10.0.0.11"]
}

variable "ip_netmask" {
  description = "IPv4 netmask"
  type        = string
  default     = "255.255.255.0"
}

variable "ip_gateway" {
  description = "IPv4 gateway address"
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

variable "dest_datastore_folder" {
  description = "Destination datastore folder for cloud-init ISO images"
  default     = "iso"
}

variable "aion_url" {
  description = "AION URL"
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

variable "os_disk_size_gb" {
  type        = number
  description = "Size of the OS disk in GB. When null size will be determined from the template image."
  default     = 500
}
