module "common" {
  source = "../../../modules/common"
}

resource "proxmox_virtual_environment_dns" "config" {
  domain    = module.common.network.domain
  node_name = module.common.proxmox_host

  servers = module.common.network.dns
}

resource "proxmox_virtual_environment_file" "alma_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = module.common.proxmox_host

  source_file {
    path = "https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-9.4-20240805.x86_64.qcow2"
    file_name = "Alma-9.4-CloudImage.img"
  }
}
