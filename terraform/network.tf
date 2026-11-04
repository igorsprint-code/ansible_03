resource "yandex_vpc_network" "ansible_network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "ansible_subnet" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.ansible_network.id
  v4_cidr_blocks = var.default_cidr
}