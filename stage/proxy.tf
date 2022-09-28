module "proxy" {
  source = "github.com/Frolls/tf-modules//vm-instance"

  vm_name     = "proxy-${terraform.workspace}"
  vm_hostname = var.domain
  vm_zone     = data.yandex_vpc_subnet.subnet-a-zone.zone

  vm_subnet_id   = yandex_vpc_subnet.stage-subnet-a.id
  vm_nat_enabled = true

  vm_image_id = "fd83slullt763d3lo57m" # nat-instance-ubuntu

  vm_cores  = 2
  vm_memory = 2

  vm_metadata = file("meta/proxy.yml")
}


