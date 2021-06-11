resource "aws_lb" "ALB" {
  name               = "flaskapp-alb"
  internal           = false
  security_groups    = [var.LoadBalancer_SG.id]
  load_balancer_type = "application"
  subnets            = [ var.PublicSubnet1a.id , var.PublicSubnet2a.id ]

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-FlaskApp-ALB"
  }
}



resource "aws_lb_target_group" "TargetGroup" {
  name     = "flaskapp-targetgroup"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.VPC.id
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





//resource "aws_alb_listener_rule" "listen_rule" {
//  listener_arn = aws_alb_listener.front_end.arn
//  priority     = 99
//
//  action {
//    type = "forward"
//    target_group_arn = aws_alb_target_group.TargetGroup.arn
//  }
//
//}