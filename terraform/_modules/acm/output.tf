output "aws_acm_certificate_validation_cert_certificate_arn" {
  value = aws_acm_certificate_validation.cert.certificate_arn
}

output "aws_route53_zone_zone_id" {
  value = data.aws_route53_zone.zone.id
}

