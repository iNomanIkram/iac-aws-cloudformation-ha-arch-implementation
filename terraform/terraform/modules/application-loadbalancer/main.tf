resource "aws_lb" "ALB" {
  name               = "flaskapp-alb"
  internal           = false
  security_groups    = [var.security_groups.LoadBalancer_SG.id]
  load_balancer_type = "application"
  subnets            = [ var.vpc.PublicSubnet[0].id , var.vpc.PublicSubnet[1].id ]

  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-FlaskApp-ALB"
  }
}



resource "aws_lb_target_group" "TargetGroup" {
  name     = "flaskapp-targetgroup"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TargetGroup.arn
  }
}
