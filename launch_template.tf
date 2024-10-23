resource "aws_launch_template" "ec2_launch_temp" {
  name     = "ec2_launch_template"
  image_id = var.ami

  instance_type = "t2.micro"
  placement {
    availability_zone = module.vpc.public_subnets
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = module.EC2-security-group.security_group_id
  }

  user_data = filebase64("user-data.sh")
}