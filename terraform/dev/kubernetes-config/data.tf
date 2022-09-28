data "tfe_outputs" "eks_cluster" {
  organization = "janes-weather"
  workspace    = "jw-tf-eks-cluster-dev"
}

data "aws_eks_cluster" "default" {
  name = nonsensitive(data.tfe_outputs.eks_cluster.values.eks_cluster_id)
}

data "aws_eks_cluster_auth" "default" {
  name = nonsensitive(data.tfe_outputs.eks_cluster.values.eks_cluster_id)
}
