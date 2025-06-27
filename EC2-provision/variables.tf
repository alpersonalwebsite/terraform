# All input variables for EC2 provisioning

variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "t2_count" {
  description = "Number of t2.micro instances."
  type        = number
  default     = 4
}

variable "m4_count" {
  description = "Number of m4.large instances."
  type        = number
  default     = 2
}

variable "t2_name_prefix" {
  description = "Name prefix for t2.micro instances."
  type        = string
  default     = "your-project-t2"
}

variable "m4_name_prefix" {
  description = "Name prefix for m4.large instances."
  type        = string
  default     = "your-project-m4"
}

variable "environment" {
  description = "Environment tag (e.g., dev, prod)."
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project tag for cost allocation."
  type        = string
  default     = "terraform-ec2-demo"
}

variable "owner" {
  description = "Owner tag for resource tracking."
  type        = string
  default     = "your-name"
}

variable "key_pair_name" {
  description = "Name for the AWS key pair."
  type        = string
  default     = "ec2-keypair"
}

variable "public_key_path" {
  description = "Path to your public SSH key file."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH (default: no open SSH). Set to your IP or VPN."
  type        = string
  default     = "0.0.0.0/0" # Change to your IP, e.g., "203.0.113.10/32"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform remote state. Must be globally unique."
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking."
  type        = string
  default     = "terraform-locks"
}

variable "backend_region" {
  description = "AWS region for the backend S3 bucket and DynamoDB table."
  type        = string
  default     = "us-east-1"
}

variable "t2_instance_type" {
  description = "Instance type for t2 instances."
  type        = string
  default     = "t2.micro"
}

variable "m4_instance_type" {
  description = "Instance type for m4 instances."
  type        = string
  default     = "m4.large"
}

variable "ami_name_filter" {
  description = "AMI name filter for Amazon Linux 2."
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2"
}

variable "cost_center" {
  description = "Cost center tag."
  type        = string
  default     = ""
}

variable "department" {
  description = "Department tag."
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Example sensitive variable for DB password."
  type        = string
  sensitive   = true
  default     = ""
}
