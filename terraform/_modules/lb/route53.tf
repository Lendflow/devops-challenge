resource "aws_route53_record" "lb" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.domain_name
  type    = "CNAME"
  ttl     = "60"
  records = [aws_lb.lb.dns_name]
}

