# AWS Lambda Elasticsearch Index Cleanup

## Overview
This AWS Lambda function allows you to delete the old Elasticsearch indexes using SigV4Auth authentication. You configure the AWS Elasticsearch Access Policy authorizing the Lambda Role or the AWS Account number instead of using the IP address whitelist.

## Diagram

<p align="center">
  <img src="https://raw.githubusercontent.com/giuliocalzolari/terraform-aws-es-cleanup/master/diagram.png">
</p>


# Terraform version
Module compatible with Terraform `0.12`


## Module Input Variables
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delete\_after | Numbers of days to preserve | string | `"15"` | no |
| es\_endpoint |  | string | n/a | yes |
| index | Index/indices to process comma separated, with all every index will be processed except '.kibana' | string | `".*"` | no |
| index\_format | Combined with 'index' varible is used to evaluate the index age | string | `"%Y.%m.%d"` | no |
| prefix |  | string | `""` | no |
| python\_version |  | string | `"3.6"` | no |
| schedule |  | string | `"cron(0 3 * * ? *)"` | no |
| security\_group\_ids | Addiational Security Ids To add. | list(string) | `[]` | no |
| skip\_index | Index/indices to skip | string | `".kibana*"` | no |
| subnet\_ids | Subnet IDs you want to deploy the lambda in. Only fill this in if you want to deploy your Lambda function inside a VPC. | list(string) | `[]` | no |
| suffix |  | string | `""` | no |
| tags | Tags to apply | map | `{ "Name": "es-cleanup" }` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "eu-west-1"
}


module "public_es_cleanup" {
  source       = "giuliocalzolari/es-cleanup/aws"
  version      = "1.13.0"
  prefix       = "public_es_"
  es_endpoint  = "test-es-XXXXXXX.eu-central-1.es.amazonaws.com"
  delete_after = 365
}


module "vpc_es_cleanup" {
  source             = "giuliocalzolari/es-cleanup/aws"
  version            = "1.13.0"
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
