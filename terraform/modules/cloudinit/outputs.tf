output "network" {
  value = yamlencode({
    version = 2
    ethernets = {
      eth0 = {
        addresses = ["${var.ip_address}/24"]
        gateway4  = "10.0.10.1"
        nameservers = {
          search = ["mandatorygoat.com"]
          addresses = [
            "10.0.10.3",
            "10.0.10.4",
          ]
        }
      }
    }
  })
}

output "userdata" {
  value = templatefile(
    "${path.module}/cloud-init.yml.tftpl", {
      hostname            = var.hostname
      additional_packages = var.additional_packages
  })
}
