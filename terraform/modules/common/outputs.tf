output "proxmox_host" {
  value = "proxmox"
}

output "vm_storage_pool" {
  value = "Pool"
}

output "cloud_image" {
  value = "local:iso/Alma-9.2-CloudImage.img"
}

output "network" {
  value = {
    gateway = "10.0.10.1"
    dns     = ["10.0.10.3", "10.0.10.4"]
    domain  = "mandatorygoat.com"
  }
}
