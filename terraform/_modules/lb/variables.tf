# variable to define the name of the ELB
variable "name" {
  type = string
}

# variable to the env
variable "env" {
  type    = string
  default = ""
}

# variable to define instance cluster
variable "instance_cluster" {
  type = string
}

# variable to the domain (the root domain, like example.com)
variable "domain" {
  type    = string
  default = ""
}

# variable to the region
variable "region" {
  type    = string
}

# the VPC environment (VPC name)
variable "vpc_env" {
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
  default     = {}
}

