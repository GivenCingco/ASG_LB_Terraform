#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the private IP address of the EC2 instance
INSTANCE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

# Write the IP address to index.html
echo "<h1>EC2 Instance IP Address: $INSTANCE_IP</h1>" > /var/www/html/index.html