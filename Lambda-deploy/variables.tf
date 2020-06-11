# TODO: Define the variable for aws_region
variable "region" {
  default = "us-east-1"
}

variable "function_name" {
  default = "greet_lambda"
}

variable "runtime" {
  default = "python3.8"
}
