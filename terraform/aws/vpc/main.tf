module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.env
  cidr = "${var.cidr_prefix}.0.0/16"

  azs              = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets  = ["${var.cidr_prefix}.10.0/24", "${var.cidr_prefix}.11.0/24", "${var.cidr_prefix}.12.0/24"]
  public_subnets   = ["${var.cidr_prefix}.0.0/24", "${var.cidr_prefix}.1.0/24", "${var.cidr_prefix}.2.0/24"]
  # database_subnets = ["${var.cidr_prefix}.20.0/24", "${var.cidr_prefix}.21.0/24", "${var.cidr_prefix}.22.0/24"]
  # elasticache_subnets = ["${var.cidr_prefix}.31.0/24", "${var.cidr_prefix}.32.0/24"]
  # redshift_subnets    = ["${var.cidr_prefix}.41.0/24", "${var.cidr_prefix}.42.0/24"]
  # intra_subnets       = ["${var.cidr_prefix}.200.0/24", "${var.cidr_prefix}.201.0/24", "${var.cidr_prefix}.202.0/24"]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_dhcp_options  = true
  enable_vpn_gateway   = false

  # database config
  create_database_subnet_group           = false
  create_database_subnet_route_table     = false
  create_database_internet_gateway_route = false

  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }
}

data "aws_ssm_parameter" "key" {
  name = "/ansible/public-key"
}

resource "aws_key_pair" "keypair" {
  key_name   = var.keypair
  public_key = data.aws_ssm_parameter.key.value
}
