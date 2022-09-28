resource "aws_kms_key" "this" {
  description         = "KMS key for cluster encryption: ${var.cluster_name}"
  enable_key_rotation = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29"

  cluster_version = "1.23"
  cluster_name    = var.cluster_name
  vpc_id          = var.vpc.vpc_id
  subnet_ids      = var.vpc.private_subnets
  enable_irsa     = true

  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  cluster_endpoint_private_access      = true

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.this.arn
    resources        = ["secrets"]
  }]

  cluster_enabled_log_types = ["audit", "api", "authenticator", "controllerManager", "scheduler"]

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  eks_managed_node_group_defaults = {
    block_device_mappings = {
      default = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size = 20
          encrypted   = true
        }
      }
    }
  }

  node_security_group_additional_rules = {
    "ingress_all" = {
      type      = "ingress"
      from_port = 0
      to_port   = 65535
      protocol  = "all"
      self      = true
    }

    "egress_all" = {
      type      = "egress"
      from_port = 0
      to_port   = 65535
      protocol  = "all"
      self      = true
    }

    ingress_karpenter_webhook_tcp = {
      description                   = "Cluster API to Node group for Karpenter webhook"
      protocol                      = "tcp"
      from_port                     = 8443
      to_port                       = 8443
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  node_security_group_tags = {
    "karpenter.sh/discovery/${var.cluster_name}" = var.cluster_name
  }

  eks_managed_node_groups = {
    default = {
      desired_size          = 1
      ami_type              = "BOTTLEROCKET_x86_64"
      instance_types        = ["t3.xlarge"]
      subnet_ids            = var.vpc.private_subnets
      create_security_group = false
      iam_role_additional_policies = [
        # Required by Karpenter
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
      tags = {
        # using subnetSelector/securityGroupSelector at Provisioner
        "karpenter.sh/discovery/${var.cluster_name}" = var.cluster_name
      }
    }
  }

  manage_aws_auth_configmap = false

}
