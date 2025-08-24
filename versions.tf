terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-backend-1755977291"
    key            = "eks-terraform-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table  = "terraform-backend-1755977291"
    encrypt        = true
  }
}