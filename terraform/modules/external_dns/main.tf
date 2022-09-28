data "aws_region" "current" {}

locals {
  service_account_name      = "external-dns"
  service_account_namespace = "kube-system"
  cluster_role_name         = "external-dns"
}

resource "aws_iam_policy" "this" {
  policy = file("${path.module}/iam-policy.json")
}

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.3.3"

  create_role      = true
  role_name_prefix = "external-dns-"
  role_description = "IRSA role for External DNS"

  provider_url                   = var.oidc_provider
  role_policy_arns               = [aws_iam_policy.this.arn]
  oidc_fully_qualified_subjects  = ["system:serviceaccount:${local.service_account_namespace}:${local.service_account_name}"]
  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]
}

resource "kubernetes_service_account" "external_dns" {
  metadata {
    name      = local.service_account_name
    namespace = local.service_account_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_assumable_role.iam_role_arn
    }
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "external_dns" {
  metadata {
    name = local.cluster_role_name
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = ["networking", "networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["endpoints"]
    verbs      = ["get", "watch", "list"]
  }

}

resource "kubernetes_cluster_role_binding" "external_dns" {
  metadata {
    name = "external-dns"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.cluster_role_name
  }
  subject {
    kind      = "ServiceAccount"
    name      = local.service_account_name
    namespace = local.service_account_namespace
  }
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  namespace  = local.service_account_namespace
  wait       = true
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  version    = "v1.11.0"

  set {
    name  = "rbac.create"
    value = false
  }

  set {
    name  = "serviceAccount.create"
    value = false
  }

  set {
    name  = "serviceAccount.name"
    value = local.service_account_name
  }

  set {
    name  = "rbac.pspEnabled"
    value = false
  }

  set {
    name  = "name"
    value = "${var.cluster_name}-external-dns"
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "logLevel"
    value = "debug"
  }

  set {
    name  = "sources"
    value = "{ingress,service}"
  }

  set {
    name  = "domainFilters"
    value = "{janesweather.net}"
  }

  set {
    name  = "aws.zoneType"
    value = ""
  }

  set {
    name  = "aws.region"
    value = data.aws_region.current.name
  }
}
