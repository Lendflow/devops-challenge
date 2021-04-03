# Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = [local.owner]
}

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
  count   = var.domain != "" && var.aws != "aws-us-gov" && var.ignore_domain == false ? 1 : 0
  name  = var.domain
}

