data "aws_route53_zone" "primary" {
  zone_id = var.zone_id
}

resource "aws_acm_certificate" "balancer" {
  domain_name       = aws_route53_record.name_alias.fqdn
  validation_method = "DNS"

  subject_alternative_names = [
    for alias in local.alias_list :
    format("%s.%s", alias, data.aws_route53_zone.primary.name)
  ]

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    map(
      "Name", var.name
    ),
    var.tags
  )

}

resource "aws_route53_record" "cert" {
  for_each = {
    for dvo in aws_acm_certificate.balancer.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = false
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 10
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "balancer" {
  certificate_arn = aws_acm_certificate.balancer.arn
  validation_record_fqdns = [
    for record in aws_route53_record.cert :
    record.fqdn
  ]
}

output "certificate_arn" {
  description = "Load balancer certificate arn"
  value       = aws_acm_certificate.balancer
}
