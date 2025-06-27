terraform {
  backend "s3" {
    bucket         = var.s3_bucket_name
    key            = "ec2-provision/terraform.tfstate"
    region         = var.backend_region
    dynamodb_table = var.dynamodb_table_name
    encrypt        = true
  }
}
