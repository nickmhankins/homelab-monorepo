packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.3"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "alma" {
  proxmox_url              = "https://10.0.10.10:8006/api2/json"
  insecure_skip_tls_verify = true
  username                 = "packer@pve"
  password                 = var.proxmox_password
  node                     = "proxmox"

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disks {
    disk_size    = "20g"
    storage_pool = "Pool"
    type         = "sata"
  }

  bios     = "ovmf"
  vm_name  = "alma92-template-${formatdate("YYYYMMDD.hhmm.ss", timestamp())}"
  cpu_type = "host"
  memory   = 2048
  cores    = 2
  sockets  = 2

  efi_config {
    efi_storage_pool  = "Pool"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }

  iso_file = "local:iso/AlmaLinux-9-latest-x86_64-minimal.iso"
  boot_command = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    "inst.nosave=all_ks inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>",
  ]

  unmount_iso    = true
  http_directory = "data"
  ssh_timeout    = "15m"
  ssh_username   = "packer"
  ssh_password   = "packer"
}

build {
  sources = ["source.proxmox-iso.alma"]
}