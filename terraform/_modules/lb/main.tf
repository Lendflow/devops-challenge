resource "aws_lb" "lb" {
  name               = var.name
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
  name        = var.name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true # required
    protocol            = "HTTP"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  depends_on = [
    aws_lb.lb
  ]
}

resource "aws_lb_listener" "reports" {
  load_balancer_arn = aws_lb.reports.arn
  port              = 5488
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.reports.arn
    type             = "forward"
  }
}
