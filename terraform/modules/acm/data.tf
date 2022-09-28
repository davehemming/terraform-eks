data "aws_route53_zone" "domain_hosted_zone" {
  name = var.root_domain
}
