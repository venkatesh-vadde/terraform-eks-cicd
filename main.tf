provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source           = "./modules/vpc"
  project_name     = var.project_name
  vpc_cidr_block   = var.vpc_cidr
}

module "eks" {
  source           = "./modules/eks"
  project_name     = var.project_name
  cluster_name     = var.cluster_name
  subnet_ids       = module.vpc.public_subnet_ids
}

output "ecr_repository_uri" {
  value = module.eks.ecr_repository_uri
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.aws_region}"
}