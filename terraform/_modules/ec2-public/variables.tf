# aws or aws-us-gov
variable "aws" {
  type    = string
  default = "aws"
}

# variable to define environment
variable "env" {
  type = string
}

# variable to define the name of the instance
variable "name" {
  type = string
}

# variable to define cluster
variable "cluster" {
  type = string
}

# variable to define role
variable "role" {
  type = string
}

# variable to the domain
variable "domain" {
  type    = string
  default = ""
}

# 
variable "urls" {
  type    = string
  default = ""
  description = "A list of URLS to include in the 'URL' instance tag. Useful for determining what URLs are served from the instance. Colon seperated ('test.example.org:www.example.org:foo.example.org')"
}

variable "ignore_domain" {
  type = bool
  default = false
}

# The hostname for DNS
variable "route53_name" {
  type    = string
  default = ""
}

# Optional 2nd route53 DNS entry.
variable "route53_name_2" {
  type    = string
  default = ""
}

# the VPC environment (VPC name)
variable "vpc_env" {
  type = string
}

# SSH key pair to use.  The SSH private/public key needs to be created and then uploaded to AWS.
variable "keypair" {
  type    = string
  default = "ansible"
}

# AWS region
variable "region" {
  type = string
}

# the instance size
variable "instance_type" {
  type = string
}

# if you need to define tenancy
variable "tenancy" {
  type    = string
  default = "default"
}

# remote IP address for initial configuration
variable "remote_user_cidr" {
  type    = string
}

variable "instance_policy_arn" {
  description = "Any additional AWS IAM policy."
  type        = string
  default     = ""
}

# Defines if we create the EBS volume.
variable "ebs" {
  type    = bool
  default = true
}

# EBS size.
variable "ebs_size" {
  type    = string
  default = "50"
}

# EBS optimized
variable "ebs_optimized" {
  type    = bool
  default = false
}

# root_size
variable "root_size" {
  type    = string
  default = "20"
}

variable "custom_security_group" {
  description = "A map"
  type        = map
  default     = {}

}

variable "custom_self_security_group" {
  description = "A map of security rules that allow the public IP address to talk to itself."
  type        = map
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
  default     = {}
}

variable "no_urls" {
  description = "A way to override URLs. For instance, if you have an openvpn instance, with DNS, but no URL."
  type = bool
  default = false
}

