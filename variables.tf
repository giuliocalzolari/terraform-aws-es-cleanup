variable "prefix" {
  description = "A prefix for the resource names, this helps create multiple instances of this stack for different environments"
  default     = ""
  type        = string
}

variable "suffix" {
  description = "A suffix for the resource names, this helps create multiple instances of this stack for different environments"
  default     = ""
  type        = string
}

variable "schedule" {
  description = "Cron Schedule expression for running the cleanup function"
  default     = "cron(0 3 * * ? *)"
  type        = string
}

variable "sns_alert" {
  description = "SNS ARN to pusblish any alert"
  default     = ""
  type        = string
}

variable "es_endpoint" {
  description = "AWS ES fqdn"
  type        = string
}

variable "index" {
  description = "Index/indices to process comma separated, with `all` every index will be processed except `.kibana`"
  default     = "all"
  type        = string
}

variable "skip_index" {
  description = "Index/indices to skip"
  default     = ".kibana"
  type        = string
}

variable "delete_after" {
  description = "Numbers of days to preserve"
  default     = 15
  type        = number
}

variable "index_format" {
  description = "Combined with `index` varible is used to evaluate the index age"
  default     = "%Y.%m.%d"
  type        = string
}

variable "python_version" {
  description = "Python version to be used"
  default     = "3.6"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs you want to deploy the lambda in. Only fill this in if you want to deploy your Lambda function inside a VPC."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Addiational Security Ids To add."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply"
  default = {
    Name = "es-cleanup"
  }
}
