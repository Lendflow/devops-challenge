# instance-public security group
resource "aws_security_group" "instance-public" {
  description = "${var.env}-${var.name}  security group"

  # outgoing rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  name = "${var.env}-${var.name}-public-inbound"
  tags = merge(
    {
      "Name" = "${var.env}-${var.name}-public-inbound"
    },
    var.tags,
    local.default_tags,
  )
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "port_22" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = distinct([data.aws_vpc.vpc.cidr_block, var.remote_user_cidr])
  description = "port 22 remote access."

  security_group_id = aws_security_group.instance-public.id
}

resource "aws_security_group_rule" "port_80" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = distinct([data.aws_vpc.vpc.cidr_block, var.remote_user_cidr])
  description = "port 80 remote access."

  security_group_id = aws_security_group.instance-public.id
}

resource "aws_security_group_rule" "port_443" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = distinct([data.aws_vpc.vpc.cidr_block, var.remote_user_cidr])
  description = "port 443 remote access."

  security_group_id = aws_security_group.instance-public.id
}

resource "aws_security_group_rule" "port_9100" {
  type        = "ingress"
  from_port   = 9100
  to_port     = 9100
  protocol    = "tcp"
  cidr_blocks = [local.local_cidr]
  description = "port 9100 remote access."

  security_group_id = aws_security_group.instance-public.id
}


# custom security group
resource "aws_security_group" "custom" {
  description = "${var.env}-${var.name} custom security group"

  # outgoing rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.custom_security_group == "" ? {} : var.custom_security_group
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_blocks]
      description = "${ingress.key} custom security group"
    }
  }

  name = "${var.env}-${var.name}-custom-inbound"
  tags = merge(
    {
      "Name" = "${var.env}-${var.name}-custom-inbound"
    },
    var.tags,
    local.default_tags,
  )
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_security_group" "custom_self" {
  description = "${var.env}-${var.name} custom self security group"

  # outgoing rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.custom_self_security_group == "" ? {} : var.custom_self_security_group
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = local.all_site_list
      description = "${ingress.key} custom self security group"
    }
  }

  name = "${var.env}-${var.name}-custom-self-inbound"
  tags = merge(
    {
      "Name" = "${var.env}-${var.name}-custom-self-inbound"
    },
    var.tags,
    local.default_tags,
  )
  vpc_id = data.aws_vpc.vpc.id
}

