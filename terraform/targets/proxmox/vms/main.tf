module "common" {
  source = "../../../modules/common"
}

module "dockerhost01" {
  source     = "../../../modules/proxmox_cloudimage_vm"
  vm_name    = "dockerhost01"
  ip_address = "10.0.10.8"
  common     = module.common
}
