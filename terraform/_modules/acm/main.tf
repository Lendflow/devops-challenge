resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.name}.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = aws_acm_certificate.cert.domain_validation_options.*.resource_record_name[0]
  records         = [aws_acm_certificate.cert.domain_validation_options.*.resource_record_value[0]]
  ttl             = 60
  type            = aws_acm_certificate.cert.domain_validation_options.*.resource_record_type[0]
  zone_id         = data.aws_route53_zone.zone.id
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

