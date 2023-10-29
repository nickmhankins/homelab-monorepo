variable "ip_address" {
  type = string
}

variable "hostname" {
  type = string
}

variable "additional_packages" {
  type    = list(string)
  default = []
}
