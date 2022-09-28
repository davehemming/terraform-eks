provider "aws" {
  allowed_account_ids = [var.aws_account_id]
  region              = var.aws_region

  default_tags {
    tags = {
      Environment = var.env
      ManagedBy   = "terraform"
      Repo        = var.repo
    }
  }
}

provider "null" {}
