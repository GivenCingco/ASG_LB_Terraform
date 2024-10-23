resource "aws_lb" "app_lb" {
  name               = "My-Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = module.ALB-security-group.security_group_id
  subnets            = module.vpc.public_subnets[*].id
  depends_on         = [module.vpc.vpc_id]


  tags = {
    Environment = "production"
  }
}

#Target group group for ALB
resource "aws_lb_target_group" "alb-target-group" {
  name        = "ALB-target-group"
  target_type = "alb"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.default_vpc_id
  tags = {
    Name = "ALB-target-group"
  }
}

#Listerner for ALB
resource "aws_lb_listener" "alb-listerner" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}