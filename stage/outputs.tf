output "proxy_external_ipv4_address" {
  value       = module.proxy.vm_external_ipv4_address
  description = "Внешний IP адрес инфраструктуры. Reverse proxy находится тут"
}

output "proxy_internal_ipv4_address" {
  value       = module.proxy.vm_internal_ipv4_address
  description = "Внутренний IP адрес инфраструктуры"
}

output "db_1_internal_ipv4_address" {
  value       = module.mysql_db01.vm_internal_ipv4_address
  description = "Внутренний IP адрес mysql_db01"
}

output "db_2_internal_ipv4_address" {
  value       = module.mysql_db02.vm_internal_ipv4_address
  description = "Внутренний IP адрес mysql_db02"
}

output "app_internal_ipv4_address" {
  value       = module.app.vm_internal_ipv4_address
  description = "Внутренний IP адрес Wordpress"
}

output "gitlab_internal_ipv4_address" {
  value       = module.gitlab.vm_internal_ipv4_address
  description = "Внутренний IP адрес GitLab"
}

output "runner_internal_ipv4_address" {
  value       = module.runner.vm_internal_ipv4_address
  description = "Внутренний IP адрес Gitlab-runner"
}

output "monitoring_internal_ipv4_address" {
  value       = module.monitoring.vm_internal_ipv4_address
  description = "Внутренний IP адрес мониторинга"
}
