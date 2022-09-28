resource "helm_release" "this" {
  name             = "aws-load-balancer-controller"
  namespace        = "kube-system"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  version          = "1.4.4"
  create_namespace = false

  set {
    name  = "region"
    value = data.aws_region.current.name
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = local.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_assumable_role.iam_role_arn
  }
}

resource "aws_iam_policy" "this" {
  policy = file("${path.module}/iam_policy.json")
}

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.3.3"

  create_role      = true
  role_name_prefix = "load_balancer_controller_"
  role_description = "IRSA role for AWS Load Balancer Controller"

  provider_url                   = var.oidc_provider
  role_policy_arns               = [aws_iam_policy.this.arn]
  oidc_fully_qualified_subjects  = ["system:serviceaccount:kube-system:${local.service_account_name}"]
  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]
}

resource "aws_security_group_rule" "cluster" {
  type                     = "ingress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  security_group_id        = var.node_security_group_id
  source_security_group_id = var.cluster_security_group_id
}
