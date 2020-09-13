output "http_listener_arn" {
  description = "HTTP listener arn"
  value       = aws_lb_listener.http.arn
}

output "http_alt_listener_arn" {
  description = "HTTP alt listener arn"
  value       = aws_lb_listener.http_alt.arn
}

output "https_listener_arn" {
  description = "HTTP listener arn"
  value       = aws_lb_listener.https.arn
}

output "https_alt_listener_arn" {
  description = "HTTP alt listener arn"
  value       = aws_lb_listener.https_alt.arn
}

output "balancer_sg" {
  description = "ALB security group"
  value       = aws_security_group.balancer.id
}
