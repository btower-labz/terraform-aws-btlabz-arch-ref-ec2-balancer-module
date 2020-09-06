variable "name" {
  type    = string
  default = "workload"
}

variable "tags" {
  description = "Additional tags. E.g. environment, backup tags etc"
  type        = map
  default     = {}
}
