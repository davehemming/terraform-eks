output "aws_acm_certificate_domain_name" {
  description = "AWS ACM Certificate Domain Name"
  value       = aws_acm_certificate.domain_name.domain_name
}

output "aws_acm_certificate_arn" {
  description = "AWS ACM Certificate ARN"
  value       = aws_acm_certificate.domain_name.arn
}
