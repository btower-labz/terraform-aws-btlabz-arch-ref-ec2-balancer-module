resource "aws_lb" "main" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups = sort(concat(
    list(aws_security_group.balancer.id),
    distinct(compact(var.security_groups))
  ))
  subnets = local.subnets
  tags = merge(
    map(
      "Name", var.name
    ),
    var.tags
  )
}
