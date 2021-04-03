
locals {
  domain_name = "${var.name}.${var.domain}"
  replaced_name = "${var.env}${var.name}"
}

