variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "ShowyK"
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "TanaMonitoring"
}

variable "sns_topic_name" {
  description = "SNS topic name for alerts"
  type        = string
  default     = "TanaAlerts"
}

variable "lambda_name" {
  description = "Lambda function name"
  type        = string
  default     = "TanaMonitoringLambda"
}

variable "lambda_role_name" {
  description = "IAM role for Lambda"
  type        = string
  default     = "TanaLambdaRole"
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function"
  type        = number
  default     = 10
}

variable "lambda_memory" {
  description = "Memory size for Lambda function"
  type        = number
  default     = 256
}
