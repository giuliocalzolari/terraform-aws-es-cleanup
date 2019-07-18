# AWS Lambda Elasticsearch Index Cleanup

## Overview
This AWS Lambda function allows you to delete the old Elasticsearch indexes using SigV4Auth authentication. You configure the AWS Elasticsearch Access Policy authorizing the Lambda Role or the AWS Account number instead of using the IP address whitelist.

## Diagram

<p align="center">
  <img src="https://raw.githubusercontent.com/giuliocalzolari/terraform-aws-es-cleanup/master/diagram.png">
</p>


# Terraform module

Particularly it creates:

1. Lambda function that does the deletion
2. IAM role and policy that allows access to ES
3. Cloudwatch event rule that triggers the lambda function on a schedule
4. (Only when your Lambda is deployed inside a VPC) Security Group for Lambda function


## Module Input Variables


| Variable Name | Example Value | Description | Default Value | Required |
| --- | --- | --- | --- |  --- |
| es_endpoint | search-es-demo-zveqnhnhjqm5flntemgmx5iuya.eu-west-1.es.amazonaws.com  | AWS ES fqdn | `None` | True |
| index |  `logstash,cwl` | Index/indices to process comma separated, with `all` every index will be processed except `.kibana` | `all` | False |
| index_format  | `%Y.%m.%d` | Combined with `index` varible is used to evaluate the index age | `%Y.%m.%d` |  False |
| delete_after | `7` | Numbers of days to preserve | `15` |  False |
| python_version | `3.6` | Python version to be used | `3.6` |  False |
| schedule | `cron(0 3 * * ? *)` | Cron Schedule expression for running the cleanup function | `cron(0 3 * * ? *)` |  False |
| sns_alert | `arn:aws:sns:eu-west-1:123456789012:sns-alert` | SNS ARN to publish any alert | | False |
| prefix | `public-` | A prefix for the resource names, this helps create multiple instances of this stack for different environments | | False |
| suffix | `-public` | A prefix for the resource names, this helps create multiple instances of this stack for different environments | | False |
| subnet_ids | `["subnet-1111111", "subnet-222222"]` | Subnet IDs you want to deploy the lambda in. Only fill this in if you want to deploy your Lambda function inside a VPC. | | False |
| security_group_ids | `["sg-1111111", "sg-222222"]` | Addiational Security Ids to add. | | False |


## Example

```
provider "aws" {
  region = "eu-west-1"
  version = "~> 1.35.0"
}


module "public_es_cleanup" {
  source       = "giuliocalzolari/es-cleanup/aws"
  version      = "1.10.2"
  prefix       = "public_es_"
  es_endpoint  = "test-es-XXXXXXX.eu-central-1.es.amazonaws.com"
  delete_after = 365
}


module "vpc_es_cleanup" {
  source             = "giuliocalzolari/es-cleanup/aws"
  version            = "1.10.0"
  prefix             = "vpc_es_"
  es_endpoint        = "vpc-gc-demo-vpc-gloo5rzcdhyiykwdlots2hdjla.eu-central-1.es.amazonaws.com"
  index              = "all"
  delete_after       = 30
  subnet_ids         = ["subnet-d8660da2"]
  security_group_ids = ["sg-02dd3aa6da1b5"]
}
```


## Authors

Module is maintained by [Giulio Calzolari](https://github.com/giuliocalzolari) with help from [these awesome contributors](AUTHORS.md).


## License

**terraform-aws-es-cleanup** is licensed under the [Apache Software License 2.0](LICENSE.md).
Originally developed by [Cloudreach](https://github.com/cloudreach/aws-lambda-es-cleanup) adapted in this repo due to [Terraform Registry Requirements](https://www.terraform.io/docs/registry/modules/publish.html)
