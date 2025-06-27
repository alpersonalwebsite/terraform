# EC2 Provisioning with Terraform

## Overview
This project provisions AWS EC2 instances using Terraform, following best practices for modularity, security, automation, and remote state management. It is designed for easy reuse and team collaboration.

## Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Remote State Management](#remote-state-management)
- [Module Structure](#module-structure)
- [Usage](#usage)
- [Customization](#customization)
- [Testing & Validation](#testing--validation)
- [Best Practices](#best-practices)
- [References](#references)

## Architecture
- Modular: Separate modules for EC2 and networking
- Parameterized: All important values are variables
- Secure: IAM roles, least-privilege, and SSH access control
- Automated: User data bootstraps instances
- Remote state: S3 + DynamoDB

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- AWS account with permissions for EC2, S3, DynamoDB, IAM
- AWS CLI installed
- Go (for Terratest, optional)

## Remote State Management
Uses an S3 bucket for state and DynamoDB for locking. All values are parameterized.

### Setup (one-time)
Replace `my-terraform-state-bucket` with your unique name:
```sh
aws s3api create-bucket --bucket my-terraform-state-bucket --region us-east-1
aws s3api put-bucket-versioning --bucket my-terraform-state-bucket --versioning-configuration Status=Enabled
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

## Module Structure
- `modules/ec2`: EC2 instance logic (type, count, tags, user data, IAM, etc.)
- `modules/network`: Security group logic (ingress/egress rules, tags)
- Root: Orchestrates modules, IAM, key pair, outputs, and backend

## Usage

### Configure AWS Credentials
Use environment variables or `aws configure`. Never hardcode credentials.

### Initialize Terraform
```sh
terraform init
```

### Customize Variables
Override defaults via CLI or `terraform.tfvars`.

### Plan & Apply
```sh
terraform plan
terraform apply
```

### Destroy
```sh
terraform destroy
```

## Customization
- Change instance types, AMI filters, tags, security group rules, etc. via variables.
- Add more modules for load balancers, RDS, etc.

## Testing & Validation
- **Static Analysis:** Use [Checkov](https://www.checkov.io/) for security and compliance checks:
  ```sh
  checkov -d .
  ```
- **Syntax & Formatting:**
  ```sh
  terraform fmt -check
  terraform validate
  ```
- **Integration Testing:** Use [Terratest](https://terratest.gruntwork.io/) (Go) to write automated tests that deploy and verify your infrastructure. Example test is provided in `test/terraform_ec2_test.go`:
  ```sh
  cd test
  go test -v
  ```
- **CI/CD:** Integrate these checks into your pipeline for every change.

## Best Practices
- Use remote state with S3 and DynamoDB.
- Restrict S3/DynamoDB access with IAM policies (see example in repo).
- Never commit secrets or state files to version control.
- Use modules for reusability and clarity.
- Parameterize all important values.
- Use `sensitive = true` for secrets.
- Tag resources for cost and ownership tracking.
- Use user data for bootstrapping, but never put secrets in user data.

## References
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terratest](https://terratest.gruntwork.io/)
- [Checkov](https://www.checkov.io/)
- [Terraform S3 Backend](https://developer.hashicorp.com/terraform/language/settings/backends/s3)