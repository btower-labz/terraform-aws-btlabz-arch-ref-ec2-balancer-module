variable "zone_id" {
  type = string
}

variable "alias_by_name" {
  type    = bool
  default = true
}

variable "alias_list" {
  type    = list(string)
  default = []
}

locals {
  alias_list = sort(distinct(compact(var.alias_list)))
}

resource "aws_route53_record" "name_alias" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"
  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "custom_alias" {
  count = length(var.alias_list)>0?length(var.alias_list):0
  zone_id = var.zone_id
  name    = element(var.alias_list,count.index)
  type    = "A"
  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}
