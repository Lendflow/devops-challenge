resource "aws_route53_zone" "_" {
  name = "lend.aws.littlefluffyclouds.io"
  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }

}

resource "aws_route53_record" "test" {
  zone_id = aws_route53_zone._.zone_id
  name    = "test"
  type    = "A"
  ttl     = "60"
  records = ["10.1.2.3"]
}

