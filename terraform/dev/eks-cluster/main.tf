module "vpc" {
  source              = "../../modules/vpc"
  name                = var.cluster_name
  env                 = var.env
  cidr                = var.cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  elasticache_subnets = var.elasticache_subnets
}

module "acm" {
  source      = "../../modules/acm"
  root_domain = var.root_domain
}

module "eks" {
  source         = "../../modules/eks"
  aws_region     = var.aws_region
  aws_account_id = var.aws_account_id
  vpc            = module.vpc
  cluster_name   = var.cluster_name
}

# resource "null_resource" "cluster" {}
