resource "yandex_vpc_network" "stage-net" {
  name        = "network-1"
  description = "Сеть"
}

resource "yandex_vpc_route_table" "route-table" {
  description = "Таблица маршрутов для подсети"
  name        = "route-table-nat"

  network_id = yandex_vpc_network.stage-net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = module.proxy.vm_internal_ipv4_address
  }

  depends_on = [module.proxy]
}

resource "yandex_vpc_subnet" "stage-subnet-a" {
  name           = "subnet-1"
  description    = "Подсеть в зоне a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.stage-net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "stage-subnet-b" {
  name           = "subnet-2"
  description    = "Подсеть в зоне b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.stage-net.id
  route_table_id = yandex_vpc_route_table.route-table.id
  v4_cidr_blocks = ["192.168.20.0/24"]

  depends_on = [yandex_vpc_route_table.route-table]
}

resource "yandex_vpc_subnet" "stage-subnet-c" {
  name           = "subnet-3"
  description    = "Подсеть в зоне c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.stage-net.id
  route_table_id = yandex_vpc_route_table.route-table.id
  v4_cidr_blocks = ["192.168.30.0/24"]

  depends_on = [yandex_vpc_route_table.route-table]
}

data "yandex_vpc_subnet" "subnet-a-zone" {
  subnet_id = yandex_vpc_subnet.stage-subnet-a.id
}

data "yandex_vpc_subnet" "subnet-b-zone" {
  subnet_id = yandex_vpc_subnet.stage-subnet-b.id
}

data "yandex_vpc_subnet" "subnet-c-zone" {
  subnet_id = yandex_vpc_subnet.stage-subnet-c.id
}