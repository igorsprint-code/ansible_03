variable "token" {
  type        = string
}

variable "cloud_id" {
  type        = string
}

variable "folder_id" {
  type        = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "ansible_network"
  description = "VPC network&subnet name"
}

variable "image" {
  type = string
  default = "ubuntu-2204-lts"  
}

variable "vm_name" {
  type = string
  default = "vm"
}

variable "vm_preemptible" {
  type = bool
  default = true
}

variable "vm_nat" {
  type = bool
  default = true
}


variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = 1
  }
}

variable "each_vm" {
  type = list(object({
    vm_name       = string
    platform_id   = string
    cpu           = number
    ram           = number
    core_fraction = number
    disk_volume   = number
    type       = string
  }))
  default = [
    { vm_name = "clickhouse", platform_id = "standard-v4a", cpu = 2, ram = 4, core_fraction = 20, disk_volume = 9, type = "network-ssd"},
    { vm_name = "vector", platform_id = "standard-v4a", cpu = 2, ram = 4, core_fraction = 20, disk_volume = 9, type = "network-hdd"},
    { vm_name = "lighthouse", platform_id = "standard-v4a", cpu = 2, ram = 4, core_fraction = 20, disk_volume = 9, type = "network-hdd" }
  ]
}