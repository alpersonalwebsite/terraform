# Outputs for EC2 provisioning

output "security_group_id" {
  description = "ID of the security group."
  value       = module.network.security_group_id
}

output "t2_instance_ids" {
  description = "IDs of the t2.micro EC2 instances."
  value       = module.t2.instance_ids
}

output "t2_public_ips" {
  description = "Public IPs of the t2.micro EC2 instances."
  value       = module.t2.public_ips
}

output "m4_instance_ids" {
  description = "IDs of the m4.large EC2 instances."
  value       = module.m4.instance_ids
}

output "m4_public_ips" {
  description = "Public IPs of the m4.large EC2 instances."
  value       = module.m4.public_ips
}

output "key_pair_name" {
  description = "Name of the key pair used for EC2 instances."
  value       = aws_key_pair.default.key_name
}
