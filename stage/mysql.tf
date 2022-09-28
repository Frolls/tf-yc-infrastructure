module "mysql_db01" {
  source = "github.com/Frolls/tf-modules//vm-instance"

  vm_name     = "db01-${terraform.workspace}"
  vm_hostname = "db01.${var.domain}"
  vm_zone     = data.yandex_vpc_subnet.subnet-b-zone.zone

  vm_subnet_id   = yandex_vpc_subnet.stage-subnet-b.id
  vm_nat_enabled = false

  vm_image_id = var.yandex_image_id

  vm_cores  = 4
  vm_memory = 4

  vm_metadata = file("meta/mysql.yml")
}

module "mysql_db02" {
  source = "github.com/Frolls/tf-modules//vm-instance"

  vm_name     = "db02-${terraform.workspace}"
  vm_hostname = "db02.${var.domain}"
  vm_zone     = data.yandex_vpc_subnet.subnet-c-zone.zone

  vm_subnet_id   = yandex_vpc_subnet.stage-subnet-c.id
  vm_nat_enabled = false

  vm_image_id = var.yandex_image_id

  vm_cores  = 4
  vm_memory = 4

  vm_metadata = file("meta/mysql.yml")
}
