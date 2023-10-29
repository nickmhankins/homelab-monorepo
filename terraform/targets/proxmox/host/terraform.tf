terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.36.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://10.0.10.10:8006/"
  username = "root@pam"
  # password = export PROXMOX_VE_PASSWORD
  insecure = true
}
