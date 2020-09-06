output "http_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "balancer_sg" {
  value = aws_security_group.balancer.id
}
