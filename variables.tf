variable "instance_name" {
  description = "Name assigned to the instance.  An instance number will be appended to the name."
  type        = string
  default     = "AION"
}

variable "instance_count" {
  description = "Number of STCv instances to create."
  type        = number
  default     = 1
}

variable "num_cpus" {
  description = "The total number of virtual processor cores to assign to STCv virtual machine"
  type        = number
  default     = "2"
}

variable "memory" {
  description = "The size of the virtual machine's memory, in MB."
  type        = number
  default     = "2048"
}

variable "template_name" {
  description = "Name of the template created from the OVA"
  type        = string
}

variable "datacenter" {
  description = "vSphere datacenter."
  type        = string
}

variable "datastore" {
  description = "vSphere datastore."
  type        = string
}

variable "resource_pool_id" {
  description = "vSphere resource pool ID."
  type        = string
}

variable "mgmt_plane_network_id" {
  description = "Management network ID."
  type        = string
}

variable "mac_address_list" {
  description = "MAC address list."
  type        = list(string)
  default     = []
}

variable "ip_address_list" {
  description = "IPv4 address list."
  type        = list(string)
  default     = []
}

variable "ip_netmask" {
  type = string
}

variable "ip_gateway" {
  type = string
}

variable "private_key_file" {
  description = "SSH private key file."
  type        = string
}

variable "public_key_file" {
  description = "SSH public key file."
  type        = string
}

variable "iso_dest" {
  description = "ISO destination path."
  type        = string
}

variable "enable_provisioner" {
  description = "Enable provisioning.  When enabled instances will be initialized with the specified variables."
  type        = bool
  default     = true
}

variable "aion_url" {
  description = "AION URL. An example URL would be https://example.spirentaion.com."
  type        = string
}

variable "aion_user" {
  description = "AION user registered on aion_url"
  type        = string
}

variable "aion_password" {
  description = "AION user password for aion_url"
  type        = string
}

variable "cluster_names" {
  description = "Instance cluster names.  List length must equal instance_count."
  type        = list(string)
  default     = []
}

variable "node_names" {
  description = "Instance cluster node names.  List length must equal instance_count."
  type        = list(string)
  default     = []
}

variable "admin_email" {
  description = "Cluster admin user email. Use this to login to instance web page.  Default is obtained from AION user information."
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "Cluster admin user password. Use this to login to to the instance web page."
  type        = string
}

variable "admin_first_name" {
  description = "Cluster admin user first name. Default is obtained from AION user information."
  type        = string
  default     = ""
}

variable "admin_last_name" {
  description = "Cluster admin user last name.  Default is obtained from AION user information."
  type        = string
  default     = ""
}

variable "local_admin_password" {
  description = "Cluster local admin password for instance SSH access.  Will use admin_password if not specified."
  type        = string
  default     = ""
}

variable "node_storage_provider" {
  description = "Cluster node storage provider"
  type        = string
  default     = "local"
}

variable "node_storage_remote_uri" {
  description = "Cluster node storage URI.  Leave blank for default when provider is local"
  type        = string
  default     = ""
}

variable "http_enabled" {
  description = "Allow HTTP access as well as HTTPS.  Normally this is not recommended."
  type        = bool
  default     = false
}

variable "metrics_opt_out" {
  description = "Opt-out of Spirent metrics data collection"
  type        = bool
  default     = false
}

variable "dest_dir" {
  description = "Destination directory on the instance where provisining files will be copied"
  type        = string
  default     = "~"
}
