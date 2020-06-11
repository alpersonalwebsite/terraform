# Deploy lambda function

We are going to deploy a Lambda function.

Notes:
1. We are not including `.tfstate` nor `.terraform` folder.
1. We are going to utilize the default VPC and subnets

## Add your credentials to `main.tf`

## Zip lambda function

```shell
zip -r lambda.zip greet_lambda.py
```

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

## Invoke Lambda locally 

```shell
aws lambda invoke --invocation-type RequestResponse --function-name greet_lambda --region us-east-1 --log-type Tail --payload '{}' out --log-type Tail \
--query 'LogResult' --output text |  base64 -d
```

or


```shell
aws lambda invoke --function-name greet_lambda --payload '{}' /dev/stdout
```

## Delete the resources

```shell
terraform destroy
```