
resource "aws_autoscaling_group" "auto_sclaling_group" {
  name                      = "auto-scaling-group"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  vpc_zone_identifier       = module.vpc.public_subnets
  target_group_arns         = [aws_lb_target_group.alb-target-group.arn]

  launch_template {
    id      = aws_launch_template.ec2_launch_temp.id
    version = "$Latest"
  }
}