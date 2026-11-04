data "yandex_compute_image" "ubuntu" {
  family = var.image
}


resource "yandex_compute_instance" "cvl" {

  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  hostname    = "${var.vm_name}-${each.value.vm_name}"
  platform_id = each.value.platform_id


  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
      type       = each.value.type
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.ansible_subnet.id
    nat                = var.vm_nat
  }

  metadata = merge(var.metadata, {
    ssh-keys = "ubuntu:${local.ssh_public}"
  })


}