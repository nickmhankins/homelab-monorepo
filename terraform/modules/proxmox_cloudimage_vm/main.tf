module "cloudinit" {
  source = "../cloudinit"

  ip_address          = var.ip_address
  hostname            = var.vm_name
  additional_packages = var.additional_packages
}


resource "proxmox_virtual_environment_file" "userdata" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.common.proxmox_host

  source_raw {
    data      = module.cloudinit.userdata
    file_name = "${var.vm_name}-cloud-init-userdata.yml"
  }
}

resource "proxmox_virtual_environment_file" "networkdata" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.common.proxmox_host

  source_raw {
    data      = module.cloudinit.network
    file_name = "${var.vm_name}-cloud-init-networkdata.yml"
  }
}

resource "proxmox_virtual_environment_vm" "docker_host_01" {
  name = var.vm_name

  node_name = var.common.proxmox_host

  agent {
    enabled = true
  }

  startup {
    order = "3"
  }

  cpu {
    type    = "host"
    sockets = var.cpus
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.common.vm_storage_pool
    file_id      = var.common.cloud_image
    interface    = "scsi0"
    size         = var.disk_size
  }

  initialization {
    datastore_id         = var.common.vm_storage_pool
    network_data_file_id = proxmox_virtual_environment_file.networkdata.id
    user_data_file_id    = proxmox_virtual_environment_file.userdata.id
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }
}
