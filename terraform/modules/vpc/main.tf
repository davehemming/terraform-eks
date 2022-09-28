module "vpc" {
  version = "3.14.2"
  source  = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.cidr
  azs  = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # enable_flow_log           = true
  # flow_log_destination_arn  = aws_s3_bucket.log_bucket.arn
  # flow_log_destination_type = "s3"

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  manage_default_security_group = true

  # Enable these to use EKS private cluster endpoint
  # https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Add tags below for subnet discovery
  # https://aws.amazon.com/premiumsupport/knowledge-center/eks-vpc-subnet-discovery/
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }
}

# resource "aws_s3_bucket" "log_bucket" {
#   bucket_prefix = "log-bucket"
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "log_bucket" {
#   bucket = aws_s3_bucket.log_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "log_bucket" {
#   bucket = aws_s3_bucket.log_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "log_bucket" {
#   bucket = aws_s3_bucket.log_bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # Allow putting access log files from elb service
# resource "aws_s3_bucket_policy" "allow_elb_access_log" {
#   bucket = aws_s3_bucket.log_bucket.id
#   policy = templatefile("${path.module}/access_log_policy.json", {
#     bucket_name = aws_s3_bucket.log_bucket.bucket
#     account_id  = data.aws_caller_identity.current.account_id
#   })
# }
