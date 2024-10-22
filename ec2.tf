module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type               = "t2.micro"
  key_name                    = module.key_pair.key_pair_name
  monitoring                  = false
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("user-data.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}