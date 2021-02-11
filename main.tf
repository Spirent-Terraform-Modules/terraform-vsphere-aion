data "vsphere_virtual_machine" "template_aion" {
  name          = var.template_name
  datacenter_id = var.datacenter_id
}

# create AION
resource "vsphere_virtual_machine" "aion" {
  count               = var.instance_count
  name                = "${var.instance_name}-${count.index}"
  resource_pool_id    = var.resource_pool_id
  datastore_id        = var.datastore_id
  num_cpus            = var.num_cpus
  memory              = var.memory
  guest_id            = data.vsphere_virtual_machine.template_aion.guest_id
  scsi_type           = data.vsphere_virtual_machine.template_aion.scsi_type
  network_interface {
    network_id        = var.mgmt_plane_network_id
    adapter_type      = data.vsphere_virtual_machine.template_aion.network_interface_types[0]
  }
  disk {
    name              = "${var.instance_name}.vmdk"
    size              = data.vsphere_virtual_machine.template_aion.disks.0.size
    thin_provisioned  = data.vsphere_virtual_machine.template_aion.disks.0.thin_provisioned
  }
  clone {
    template_uuid     = data.vsphere_virtual_machine.template_aion.id
  }
}

data "template_file" "setup_aion" {
  count    = var.enable_provisioner ? var.instance_count : 0
  template = file("${path.module}/setup-aion.tpl")
  vars = {
    script_file             = "${var.dest_dir}/setup-aion.py"
    platform_addr           = vsphere_virtual_machine.aion[count.index].default_ip_address
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
  count = var.enable_provisioner ? var.instance_count : 0
  connection {
    host        = vsphere_virtual_machine.aion[count.index].default_ip_address
    type        = "ssh"
    user        = "debian"
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