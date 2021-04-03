
module "nginx-01" {
  source = "../../_modules/ec2-public"

  name = "nginx-01"
  env = var.env
  cluster = "lend"
  role = "nginx"
  instance_type = "t3.small"
  region = var.region
  route53_name = "nginx-01"
  domain = "lend.aws.littlefluffyclouds.io"
  vpc_env = "lend"
  ebs_size = "10"
  remote_user_cidr = "71.150.180.193/32"
  custom_security_group = {
    global_22 = {
      type = "ingress"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }
}

module "nginx-02" {
  source = "../_modules/ec2-public"

  name = "nginx-02"
  env = var.env
  cluster = "lend"
  role = "nginx"
  instance_type = "t3.small"
  region = var.region
  route53_name = "nginx-02"
  domain = "lend.aws.littlefluffyclouds.io"
  vpc_env = "lend"
  ebs_size = "10"
  remote_user_cidr = "71.150.180.193/32"
  custom_security_group = {
    global_22 = {
      type = "ingress"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }
}

module "nginx-03" {
  source = "../_modules/ec2-public"

  name = "nginx-03"
  env = var.env
  cluster = "lend"
  role = "nginx"
  instance_type = "t3.small"
  region = var.region
  route53_name = "nginx-03"
  domain = "lend.aws.littlefluffyclouds.io"
  vpc_env = "lend"
  ebs_size = "10"
  remote_user_cidr = "71.150.180.193/32"
  custom_security_group = {
    global_22 = {
      type = "ingress"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }
}
