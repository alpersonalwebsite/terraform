terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Use the latest Amazon Linux 2 AMI for the region
# This avoids hardcoding AMI IDs and ensures up-to-date images

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_key_pair" "default" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

resource "aws_iam_role" "ec2_s3_access" {
  name = "ec2-s3-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
  tags = {
    Name        = "ec2-s3-access-role"
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
  }
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "ec2-s3-access-policy"
  role = aws_iam_role.ec2_s3_access.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Resource = [
        "arn:aws:s3:::my-terraform-state-bucket",
        "arn:aws:s3:::my-terraform-state-bucket/*"
      ]
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2-s3-access-profile"
  role = aws_iam_role.ec2_s3_access.name
}

module "network" {
  source = "./modules/network"
  vpc_id = data.aws_vpc.default.id
  allowed_ssh_cidr = var.allowed_ssh_cidr
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.allowed_ssh_cidr]
      description = "SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "All traffic"
    }
  ]
  tags = {
    Name        = "ec2-instance-sg"
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
    CostCenter  = var.cost_center
    Department  = var.department
  }
}

module "t2" {
  source = "./modules/ec2"
  ami_id = data.aws_ami.amazon_linux.id
  instance_type = var.t2_instance_type
  count = var.t2_count
  name_prefix = var.t2_name_prefix
  key_name = aws_key_pair.default.key_name
  security_group_ids = [module.network.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl start nginx
    systemctl enable nginx
    echo "Hello from Terraform EC2 instance!" > /usr/share/nginx/html/index.html
  EOF
  tags = {
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
    CostCenter  = var.cost_center
    Department  = var.department
  }
}

module "m4" {
  source = "./modules/ec2"
  ami_id = data.aws_ami.amazon_linux.id
  instance_type = var.m4_instance_type
  count = var.m4_count
  name_prefix = var.m4_name_prefix
  key_name = aws_key_pair.default.key_name
  security_group_ids = [module.network.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl start nginx
    systemctl enable nginx
    echo "Hello from Terraform EC2 instance!" > /usr/share/nginx/html/index.html
  EOF
  tags = {
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
    CostCenter  = var.cost_center
    Department  = var.department
  }
}
