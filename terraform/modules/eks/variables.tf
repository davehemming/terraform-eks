variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_region" {
  default     = "ap-southeast-2"
  description = "Asia Pacific (Sydney) Region"
  type        = string
}

variable "vpc" {
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = ""
}
