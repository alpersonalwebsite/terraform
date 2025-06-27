# EC2 Module Outputs

output "instance_ids" {
  description = "IDs of the EC2 instances."
  value       = aws_instance.this[*].id
}

output "public_ips" {
  description = "Public IPs of the EC2 instances."
  value       = aws_instance.this[*].public_ip
}
