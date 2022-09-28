terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "janes-weather"

    workspaces {
      name = "jw-tf-eks-cluster-dev"
    }
  }
}
