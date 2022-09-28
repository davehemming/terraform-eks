output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}
output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "eks_oidc_provider" {
  description = "Kubernetes OIDC Provider"
  value       = module.eks.oidc_provider
}

output "eks_oidc_provider_arn" {
  description = "Kubernetes OIDC Provider ARN"
  value       = module.eks.oidc_provider_arn
}

output "eks_node_security_group_id" {
  description = "Kubernetes Node Security Group ID"
  value       = module.eks.node_security_group_id
}

output "eks_managed_node_group_iam_role_name" {
  description = "Managed Node Group IAM Role Name"
  value       = module.eks.eks_managed_node_groups["default"].iam_role_name
}

output "eks_managed_node_group_iam_role_arn" {
  description = "Managed Node Group IAM Role ARN"
  value       = module.eks.eks_managed_node_groups["default"].iam_role_arn
}
