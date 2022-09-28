module "auth" {
  source          = "../../modules/auth"
  cluster_name    = local.eks_cluster_id
  admin_users     = var.admin_users
  developer_users = var.developer_users
}

module "karpenter" {
  source            = "../../modules/karpenter"
  cluster_name      = local.eks_cluster_id
  cluster_id        = local.eks_cluster_id
  cluster_endpoint  = local.eks_cluster_endpoint
  iam_role_arn      = local.eks_managed_node_group_iam_role_arn
  iam_role_name     = local.eks_managed_node_group_iam_role_name
  oidc_provider_arn = local.eks_oidc_provider_arn
  public_subnet_ids = local.vpc_public_subnets
}

module "datadog" {
  source           = "../../modules/datadog"
  cluster_id       = local.eks_cluster_id
  cluster_endpoint = local.eks_cluster_endpoint
  datadog_api_key  = var.datadog_api_key
}

module "load_balancer_controller" {
  source                    = "../../modules/load_balancer_controller"
  oidc_provider             = local.eks_oidc_provider
  cluster_name              = local.eks_cluster_id
  vpc_id                    = local.vpc_id
  node_security_group_id    = local.eks_node_security_group_id
  cluster_security_group_id = local.eks_cluster_security_group_id
}

module "external_dns" {
  source        = "../../modules/external_dns"
  depends_on    = [module.load_balancer_controller]
  cluster_name  = local.eks_cluster_id
  oidc_provider = local.eks_oidc_provider
}
