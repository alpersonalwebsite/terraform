# Network Module Variables

variable "vpc_id" {
  description = "VPC ID to use."
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH."
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules. Each rule is a map with keys: from_port, to_port, protocol, cidr_blocks, description."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules. Each rule is a map with keys: from_port, to_port, protocol, cidr_blocks, description."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the security group."
  type        = map(string)
  default     = {}
}
