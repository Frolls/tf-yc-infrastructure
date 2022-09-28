module "gitlab" {
  source = "github.com/Frolls/tf-modules//vm-instance"

  vm_name     = "gitlab-${terraform.workspace}"
  vm_hostname = "gitlab.${var.domain}"
  vm_zone     = data.yandex_vpc_subnet.subnet-b-zone.zone

  vm_subnet_id   = yandex_vpc_subnet.stage-subnet-b.id
  vm_nat_enabled = false

  vm_image_id = var.yandex_image_id

  vm_cores  = 4
  vm_memory = 4

  vm_metadata = file("meta/gitlab.yml")
}
