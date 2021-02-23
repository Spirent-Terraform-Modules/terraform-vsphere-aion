
data "vsphere_datacenter" "aion" {
  name = var.datacenter
}

data "vsphere_datastore" "aion" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.aion.id
}

data "vsphere_virtual_machine" "template_aion" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.aion.id
}

# create AION
resource "vsphere_virtual_machine" "aion" {
  count    = var.instance_count
  name     = "${var.instance_name}-${count.index}"
  num_cpus = var.num_cpus
  memory   = var.memory

  resource_pool_id = var.resource_pool_id
  datastore_id     = data.vsphere_datastore.aion.id
  guest_id         = data.vsphere_virtual_machine.template_aion.guest_id
  scsi_type        = data.vsphere_virtual_machine.template_aion.scsi_type

  # Don't wait for guest networking
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  network_interface {
    network_id   = var.mgmt_plane_network_id
    adapter_type = data.vsphere_virtual_machine.template_aion.network_interface_types[0]

    use_static_mac = length(var.macs) > 0 ? true : false
    mac_address    = length(var.macs) > 0 ? var.macs[count.index] : null
  }

  disk {
    name             = "${var.instance_name}.vmdk"
    size             = data.vsphere_virtual_machine.template_aion.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template_aion.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template_aion.disks.0.thin_provisioned
    unit_number      = 0
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template_aion.id
  }

  cdrom {
    datastore_id = data.vsphere_datastore.aion.id
    path         = vsphere_file.iso[count.index].destination_file
  }
}

resource "vsphere_file" "iso" {
  depends_on         = [null_resource.geniso]
  count              = var.instance_count
  datacenter         = data.vsphere_datacenter.aion.name
  datastore          = data.vsphere_datastore.aion.name
  source_file        = "${path.module}/tmp-${random_id.uid.id}/instance-${count.index}/cloud-init.iso"
  destination_file   = "${var.dest_datastore_folder}/cloud-init-${count.index}-${random_id.uid.id}.iso"
  create_directories = true
}

# create/remote temp directory
resource "null_resource" "temp_dir" {
  triggers = {
    temp_dir = "${path.module}/tmp-${random_id.uid.id}"
  }
  provisioner "local-exec" {
    command = "mkdir ${self.triggers.temp_dir}"
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm -rf ${self.triggers.temp_dir}"
  }
}

resource "local_file" "cloud_cfg" {
  depends_on         = [null_resource.temp_dir]
  count    = var.instance_count
  content  = <<-EOT
  SSH_PUBLIC_KEY="${file(var.public_key_file)}"
  IPV4_ADDR=${var.ips[count.index]}
  IPV4_NETMASK=${var.ip_netmask}
  IPV4_GATEWAY=${var.ip_gateway}
  TMP_DIR=${path.module}/tmp-${random_id.uid.id}/instance-${count.index}
  ISO=cloud-init.iso
  EOT
  filename = "${path.module}/tmp-${random_id.uid.id}/cfg-${count.index}.sh"
}

resource "random_id" "uid" {
  byte_length = 8
}

# generate ISO
resource "null_resource" "geniso" {
  count = var.instance_count
  # run generate iso
  provisioner "local-exec" {
    command = "bash ${path.module}/geniso.sh ${local_file.cloud_cfg[count.index].filename}"
  }
}

data "template_file" "setup_aion" {
  count    = var.enable_provisioner ? var.instance_count : 0
  template = file("${path.module}/setup-aion.tpl")
  vars = {
    script_file             = "${var.dest_dir}/setup-aion.py"
    platform_addr           = var.ips[count.index]
    aion_url                = var.aion_url
    aion_user               = var.aion_user
    aion_password           = var.aion_password
    cluster_name            = length(var.cluster_names) < 1 ? "" : var.cluster_names[count.index]
    node_name               = length(var.node_names) < 1 ? "" : var.node_names[count.index]
    admin_email             = var.admin_email
    admin_first_name        = var.admin_first_name
    admin_last_name         = var.admin_last_name
    admin_password          = var.admin_password
    local_admin_password    = var.local_admin_password
    node_storage_provider   = var.node_storage_provider
    node_storage_remote_uri = var.node_storage_remote_uri
    metrics_opt_out         = var.metrics_opt_out
    http_enabled            = var.http_enabled
  }
}

# provision the AION VM
resource "null_resource" "provisioner" {
  depends_on = [vsphere_virtual_machine.aion]
  count      = var.enable_provisioner ? var.instance_count : 0
  connection {
    host        = var.ips[count.index]
    type        = "ssh"
    user        = "debian"
    private_key = file(var.private_key_file)
  }

  # force provisioners to rerun
  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  # copy install script
  provisioner "file" {
    source      = "${path.module}/setup-aion.py"
    destination = "${var.dest_dir}/setup-aion.py"
  }

  provisioner "file" {
    content     = data.template_file.setup_aion[count.index].rendered
    destination = "${var.dest_dir}/setup-aion.sh"
  }

  # run setup AION
  provisioner "remote-exec" {
    inline = [
      "bash ${var.dest_dir}/setup-aion.sh"
    ]
  }
}
