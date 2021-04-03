variable "name" {
  type    = string
  default = "www"
}

# the Route53 domain
variable "domain" {
  type = string
}

variable "tags" {
  description = "Tags dictionary"
  default     = {}
  type        = map(string)
}

