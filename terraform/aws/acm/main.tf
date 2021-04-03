module "acm" {
  source = "../../_modules/acm"

  name = "www"
  domain = "lend.aws.littlefluffyclouds.io"

  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }
}

output "arn" {
  value = module.acm.aws_acm_certificate_validation_cert_certificate_arn
}
