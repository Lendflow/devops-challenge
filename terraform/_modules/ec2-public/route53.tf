resource "aws_route53_record" "instance-public" {
  count   = var.route53_name != "" ? 1 : 0
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = var.route53_name
  type    = "A"
  ttl     = "60"
  records = [aws_eip.instance-public.public_ip]
}

resource "aws_route53_record" "instance-public-2" {
  count   = var.route53_name_2 == "" ? 0 : 1
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = var.route53_name_2
  type    = "A"
  ttl     = "60"
  records = [aws_eip.instance-public.public_ip]
}

resource "aws_route53_record" "instance-private" {
  count   = var.domain != "" && var.aws != "aws-us-gov" && var.ignore_domain == false ? 1 : 0
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = "private-${var.name}"
  type    = "A"
  ttl     = "60"
  records = [aws_instance.instance-public.private_ip]
}

