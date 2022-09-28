module "monitoring" {
  source = "github.com/Frolls/tf-modules//vm-instance"

  vm_name     = "monitoring-${terraform.workspace}"
  vm_hostname = "monitoring.${var.domain}"
  vm_zone     = data.yandex_vpc_subnet.subnet-c-zone.zone

  vm_subnet_id   = yandex_vpc_subnet.stage-subnet-c.id
  vm_nat_enabled = false

  vm_image_id = var.yandex_image_id

  vm_cores  = 4
  vm_memory = 4

  vm_metadata = file("meta/monitoring.yml")
}
