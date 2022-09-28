resource "aws_acm_certificate" "domain_name" {
  domain_name               = var.root_domain
  subject_alternative_names = ["*.${var.root_domain}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "domain_name_acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.domain_name.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.domain_hosted_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [
    each.value.record,
  ]

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "domain_name" {
  certificate_arn         = aws_acm_certificate.domain_name.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_name_acm_validation : record.fqdn]
}

