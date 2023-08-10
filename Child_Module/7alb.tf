
#create target groups for ALB
resource "aws_lb_target_group" "techno_target_group" {
  health_check {
    enabled             = var.health_check_status
    interval            = var.health_check_interval
    path                = var.health_check_path
    protocol            = "HTTP"
    timeout             = var.target_group_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold

  }

  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = var.target_group_type
  vpc_id      = aws_vpc.vpc.id
}


#create the appplication load balancer

resource "aws_lb" "load_balancer" {
  name               = var.load_balancer_name
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = ["${aws_security_group.alb_sg.id}"]
  /*subnets            = ["${aws_subnet.public_subnets.*.id}"]*/
  subnets = aws_subnet.public_subnets.*.id

  enable_deletion_protection = var.enable_deletion_protection
  tags = {
    Name = "${var.descriptor_b}-ALB"
    Environment = "${var.env}-environment"
  }
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

# create a listener on port 443 with forward action
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.acm_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.techno_target_group.arn
  }

  depends_on = [aws_acm_certificate_validation.acm_certificate_validation]

}

