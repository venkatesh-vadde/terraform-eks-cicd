variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "eks-demo"
}

variable "bucket_name" {
  type        = string
  description = "A globally unique name for the S3 bucket."
}

variable "dynamodb_table_name" {
  type        = string
  description = "A unique name for the DynamoDB lock table."
}