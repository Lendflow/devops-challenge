
locals {
  owner = var.aws == "aws" ? "099720109477" : "513442679011"
  local_cidr = "10.0.0.0/8"

  replaced_env = replace(var.env, ".", "_")
  route53_name = var.route53_name != "" ? "${var.route53_name}.${var.domain}" : ""
  route53_name_2 = var.route53_name_2 != "" ? "${var.route53_name_2}.${var.domain}" : ""
  url_list = compact(concat(split(":", var.urls), [local.route53_name], [local.route53_name_2]))
  urls = var.no_urls ? "" : join(":", local.url_list)


  default_tags = {
    Terraform   = "true"
    Environment = var.env
    Cluster     = var.cluster
    Domain      = var.domain
    URLS = local.urls
  }

  site_list = [var.remote_user_cidr]

  vpc_security_group_ids = compact([aws_security_group.instance-public.id, aws_security_group.custom.id])
}

