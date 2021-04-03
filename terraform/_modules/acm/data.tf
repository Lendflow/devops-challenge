data "aws_route53_zone" "zone" {
  name = var.domain
}

data "aws_caller_identity" "current" {
}

