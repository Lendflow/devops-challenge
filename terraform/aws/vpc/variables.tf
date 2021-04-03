# the environment
variable "env" {
  type = string
}

# the VPC CIDR prefix to use. For instance, '10.76' creates a VPC with 10.76.0.0/16
variable "cidr_prefix" {
  type    = string
}

# SSH key pair to create 
variable "keypair" {
  type    = string
  default = "ansible"
}

# AWS region
variable "region" {
  type    = string
  default = "us-east-1"
}

# GitHub
variable "github" {
  type = string
}

