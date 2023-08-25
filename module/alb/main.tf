resource "aws_lb_target_group" "lb_target_group" {
  name     = var.lb_target_group_name
  port     = var.lb_target_group_prot
  protocol = var.lb_target_group_protocol
  vpc_id   = var.lb_target_group_vpc_id

  health_check {
    enabled             = var.lb_tg_health_check_enabled
    interval            = var.lb_tg_health_check_interval
    path                = var.lb_tg_health_check_path
    port                = var.lb_tg_health_check_port
    timeout             = var.lb_tg_health_check_timeout
    healthy_threshold   = var.lb_tg_health_check_healthy_threshold
    unhealthy_threshold = var.lb_tg_health_check_unhealthy_threshold
  }

   tags = {
    Name = var.lb_target_group_name
  }
}

resource "aws_lb" "lb" {
  internal           = var.lb_internal
  load_balancer_type = var.lb_load_balancer_type
  name               = var.lb_name
  security_groups    = [var.lb_security_groups]
  enable_deletion_protection = var.lb_enable_deletion_protection
  subnets            = var.lb_subnet_mapping

tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_listener" "lb_listener_HTTP" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

