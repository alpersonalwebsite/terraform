# Provision EC2 instances

We are going to provision...
* 4 AWS t2.micro EC2 instances named Udacity T2
* 2 m4.large EC2 instances named Udacity M4

Notes:
1. We are not including `.tfstate` nor `.terraform` folder.
1. We are going to utilize the default VPC and subnets

## Add your credentials to `main.tf`

## Initialize a working directory containing Terraform configuration files

```shell
terraform init
```

## Create execution plan

```shell
terraform plan
```
## Apply changes 
(aka, reach the desired state of the configuration)

```shell
terraform apply
```

**Example output:**
```shell
Plan: 6 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

...
...
...

aws_instance.Udacity-M4[1]: Creation complete after 44s [id=i-09f20fcc2cc881ec4]
aws_instance.Udacity-M4[0]: Creation complete after 44s [id=i-045ce4c2e734c0bad]
aws_instance.Udacity-T2[1]: Creation complete after 50s [id=i-035da48a57aea2265]
aws_instance.Udacity-T2[3]: Creation complete after 50s [id=i-02ab22c94071b34b6]
aws_instance.Udacity-T2[0]: Creation complete after 50s [id=i-056d633916dd59c9b]
aws_instance.Udacity-T2[2]: Creation complete after 51s [id=i-08d8ac489425c8327]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```

If you want to remove the EC2 instances `m4.large`, you can delete its resource block or comment it out.
Then...
```shell
terraform plan

terraform apply
```

**Example output:**
```
Plan: 0 to add, 0 to change, 2 to destroy.
...
```

## Delete the resources

```shell
terraform destroy
```

*Note:* `terraform destroy` will delete the EC2 instances and update `terraform.tfstate` (we will have a new version)