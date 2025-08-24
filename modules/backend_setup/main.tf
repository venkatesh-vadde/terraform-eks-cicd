provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }
  tags = {
    Name = "${var.project_name}-tf-state"
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate_access_block" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "${var.project_name}-tf-lock"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tfstate_bucket.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.tfstate_lock.name
}