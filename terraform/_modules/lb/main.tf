resource "aws_lb" "lb" {
  name               = local.replaced_name
  internal           = false
  load_balancer_type = "network"
  ip_address_type    = "ipv4"

  subnets = [
    data.aws_subnet.a.id,
    data.aws_subnet.b.id,
    data.aws_subnet.c.id
  ]

}

resource "aws_lb_target_group" "lb" {
  name               = local.replaced_name
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "instance"

  health_check {
    enabled             = true # required
    protocol            = "TCP"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval = 30
  }

  depends_on = [
    aws_lb.lb
  ]
}

resource "aws_lb_listener" "lb" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb.arn
  }
}


resource "aws_lb_target_group_attachment" "lb" {
  count = length(data.aws_instances.lb.ids)
  target_group_arn = aws_lb_target_group.lb.arn
  target_id = data.aws_instances.lb.ids[count.index]
  port = 80
}

