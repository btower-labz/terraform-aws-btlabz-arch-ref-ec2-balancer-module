resource "aws_lb" "main" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  #security_groups    = var.sgs
  subnets = var.subnets
}
