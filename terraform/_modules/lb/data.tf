data "aws_caller_identity" "current" {}

# VPC lookup
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_env]
  }
}

data "aws_subnet" "a" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_env}-public-${var.region}a"]
  }
}

data "aws_subnet" "b" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_env}-public-${var.region}b"]
  }
}

data "aws_subnet" "c" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_env}-public-${var.region}c"]
  }
}

data "aws_route53_zone" "zone" {
  name  = var.domain
}

data "aws_acm_certificate" "issued" {
  domain   = local.domain_name
  statuses = ["ISSUED"]
}

data "aws_instances" "lb" {
  instance_tags = {
   Cluster = var.instance_cluster
  }
  instance_state_names = ["running", "stopped"]
}
