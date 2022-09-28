output "aws_account_id" {
  description = "The ID of the one AWS account this code is permitted to run against"
  value       = var.aws_account_id
  sensitive   = false
}

output "aws_region" {
  description = "Asia Pacific (Sydney) Region"
  value       = var.aws_region
  sensitive   = false
}

output "repo" {
  description = "Code repository"
  value       = var.repo
  sensitive   = false
}

output "vpc_id" {
  value     = module.vpc.vpc_id
  sensitive = false
}

output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.eks_cluster_id
  sensitive   = false
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.eks_cluster_endpoint
  sensitive   = false
}

output "eks_cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.eks_cluster_security_group_id
  sensitive   = false
}

output "eks_oidc_provider" {
  description = "Kubernetes OIDC Provider"
  value       = module.eks.eks_oidc_provider
  sensitive   = false
}

output "eks_oidc_provider_arn" {
  description = "Kubernetes OIDC Provider ARN"
  value       = module.eks.eks_oidc_provider_arn
  sensitive   = false
}

output "eks_node_security_group_id" {
  description = "Kubernetes Node Security Group ID"
  value       = module.eks.eks_node_security_group_id
  sensitive   = false
}

output "eks_managed_node_group_iam_role_name" {
  description = "Managed Node Group IAM Role Name"
  value       = module.eks.eks_managed_node_group_iam_role_name
  sensitive   = false
}

output "eks_managed_node_group_iam_role_arn" {
  description = "Managed Node Group IAM Role ARN"
  value       = module.eks.eks_managed_node_group_iam_role_arn
  sensitive   = false
}

output "vpc_public_subnets" {
  description = "VPC Public Subnets"
  value       = module.vpc.public_subnets
  sensitive   = false
}

output "vpc_private_subnets" {
  description = "VPC Private Subnets"
  value       = module.vpc.private_subnets
  sensitive   = false
}
