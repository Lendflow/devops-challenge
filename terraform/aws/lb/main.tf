module "lb" {
  source = "../../_modules/lb"

  name = "www"
  domain = "lend.aws.littlefluffyclouds.io"
  instance_cluster = "lend"
  region = var.region
  vpc_env = "lend"

  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }
}

