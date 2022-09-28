variable "domain" {
  default = "frolls.xyz"
}

variable "zone_id" {
  default = "394f5efb87fb3c74fcb4e4d642284cd3"
}

variable "server_names" {
  description = "Имена серверов в моем домене"
  type        = list(string)
  default = [
    "www",
    "gitlab",
    "grafana",
    "prometheus",
  "alertmanager"]
}
