data "template_file" "gateway" {
  template = file("${path.root}/templates/gatewayed.yml")

  vars = {
    user                        = var.user
    proxy_external_ipv4_address = module.proxy.vm_external_ipv4_address
  }
}

resource "local_file" "gateway" {
  content  = data.template_file.gateway.rendered
  filename = "../../../ansible/playbooks/group_vars/gatewayed.yml"

  depends_on = [module.proxy]
}

data "template_file" "inventory" {
  template = file("${path.root}/templates/${terraform.workspace}.yml")

  vars = {
    workspace = terraform.workspace

    user = var.user

    domain = var.domain

    proxy_hostname              = module.proxy.vm_hostname
    proxy_external_ipv4_address = module.proxy.vm_external_ipv4_address

    db01_hostname              = module.mysql_db01.vm_hostname
    db01_internal_ipv4_address = module.mysql_db01.vm_internal_ipv4_address

    db02_hostname              = module.mysql_db02.vm_hostname
    db02_internal_ipv4_address = module.mysql_db02.vm_internal_ipv4_address

    wordpress_hostname              = module.app.vm_hostname
    wordpress_internal_ipv4_address = module.app.vm_internal_ipv4_address

    monitoring                       = module.monitoring.vm_hostname
    monitoring_internal_ipv4_address = module.monitoring.vm_internal_ipv4_address

    gitlab                       = module.gitlab.vm_hostname
    gitlab_internal_ipv4_address = module.gitlab.vm_internal_ipv4_address

    runner                       = module.runner.vm_hostname
    runner_internal_ipv4_address = module.runner.vm_internal_ipv4_address
  }
}

resource "local_file" "inventory" {
  content  = data.template_file.inventory.rendered
  filename = "../../../ansible/playbooks/inventory/${terraform.workspace}.yml"

  depends_on = [module.proxy]
}

data "template_file" "web_servers" {
  template = file("${path.root}/templates/web_servers.yml")

  vars = {
    workspace = terraform.workspace

    wordPress_hostname     = "www.${var.domain}"
    wordpress_ipv4_address = module.app.vm_internal_ipv4_address

    gitLab_hostname     = module.gitlab.vm_hostname
    gitlab_ipv4_address = module.gitlab.vm_internal_ipv4_address

    grafana_hostname     = "grafana.${var.domain}"
    grafana_ipv4_address = module.monitoring.vm_internal_ipv4_address

    prometheus_hostname     = "prometheus.${var.domain}"
    prometheus_ipv4_address = module.monitoring.vm_internal_ipv4_address

    alertmanager_hostname     = "alertmanager.${var.domain}"
    alertmanager_ipv4_address = module.monitoring.vm_internal_ipv4_address
  }
}

resource "local_file" "web_servers" {
  content  = data.template_file.web_servers.rendered
  filename = "../../../ansible/playbooks/group_vars/web_servers.yml"

  depends_on = [
    module.app,
    module.gitlab,
  module.monitoring]
}

resource "local_file" "domain" {
  content  = var.domain
  filename = "${path.root}/DNS/domain"

  depends_on = [module.proxy]
}

resource "local_file" "ip_from_dns" {
  content  = module.proxy.vm_external_ipv4_address
  filename = "${path.root}/DNS/ip"

  depends_on = [module.proxy]
}

# ресурсы не освобождаются (!) после выполнения terraform destroy
resource "null_resource" "DNS" {
  provisioner "local-exec" {
    command = "cd ${path.root}/DNS && terraform init && terraform apply -auto-approve"
  }

  depends_on = [local_file.ip_from_dns]
}
