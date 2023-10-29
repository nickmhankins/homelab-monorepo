variable "vm_name" {
  type = string
}

variable "common" {
  type = any
}

variable "memory" {
  default = 2048
  type    = number
}

variable "ip_address" {
  type = string
}

variable "disk_size" {
  default = 20
  type    = number
}

variable "cpus" {
  default = 2
  type    = number
}

variable "additional_packages" {
  type    = list(string)
  default = []
}
