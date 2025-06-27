resource "aws_instance" "this" {
  count         = var.count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile
  user_data             = var.user_data
  tags = merge({
    Name = "${var.name_prefix}-${format("%02d", count.index + 1)}"
  }, var.tags)
  disable_api_termination = true
  lifecycle {
    prevent_destroy      = true
    create_before_destroy = true
  }
}
