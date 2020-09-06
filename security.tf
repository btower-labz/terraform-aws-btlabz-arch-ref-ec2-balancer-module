variable "security_groups" {
  type        = list
  description = "Additional security groups for the balancer"
  default     = []
}

variable "balancer_egress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "balancer_ingress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}

locals {
  security_groups = sort(concat(
    list(aws_security_group.balancer.id),
    distinct(compact(var.security_groups))
  ))
}

resource "aws_security_group" "balancer" {
  name        = format("%s-sg", var.name)
  description = "Allow Workload Access"
  vpc_id      = data.aws_vpc.main.id
  tags = merge(
    map(
      "Name", format("%s-sg", var.name)
    ),
    var.tags
  )
}

resource "aws_security_group_rule" "balancer_default_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.balancer_egress_cidr
  security_group_id = aws_security_group.balancer.id
}

resource "aws_security_group_rule" "balancer_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.balancer_ingress_cidr
  security_group_id = aws_security_group.balancer.id
}

resource "aws_security_group_rule" "balancer_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.balancer_ingress_cidr
  security_group_id = aws_security_group.balancer.id
}

resource "aws_security_group_rule" "balancer_in_http_alt" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = var.balancer_ingress_cidr
  security_group_id = aws_security_group.balancer.id
}

resource "aws_security_group_rule" "balancer_in_https_alt" {
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = var.balancer_ingress_cidr
  security_group_id = aws_security_group.balancer.id
}
