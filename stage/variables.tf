
# переменные для stage

variable "yandex_cloud_id" {
  description = "ID облака"
  type        = string
  default     = "b1gkvhe2rk0g1fi0uu3t"
}

variable "yandex_folder_id" {
  description = "ID папки"
  type        = string
  default     = "b1gav9nslcgv47g7gpim"
}

# Развернем везде один и тот же образ. Пусть будет Ubuntu 18.04, аналогично NAT
variable "yandex_image_id" {
  description = "Идентификатор образа"
  type        = string
  default     = "fd8hvlnfb66dgavf0e1a" # ubuntu-1804-lts
}

variable "domain" {
  default = "frolls.xyz"
}

variable "user" {
  default = "frolls"
}