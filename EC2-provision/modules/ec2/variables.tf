# EC2 Module Variables

variable "ami_id" {
  description = "AMI ID to use for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "count" {
  description = "Number of EC2 instances to launch."
  type        = number
  default     = 1
}

variable "name_prefix" {
  description = "Prefix for the Name tag."
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate."
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to apply to the instance."
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script to run at launch."
  type        = string
  default     = ""
}
