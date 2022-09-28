variable "aws_account_id" {
  description = "The id of the one AWS account this code is permitted to run against"
  type        = string
}

variable "aws_region" {
  default     = "ap-southeast-2"
  description = "Asia Pacific (Sydney) Region"
  type        = string
}

variable "repo" {
  description = "Code repository"
  default     = ""
}

variable "root_domain" {
  description = "The Root Domain Name e.g. janesweather.net"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = ""
}

variable "env" {
  description = "Environment that is used as placeholder"
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "azs" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "elasticache_subnets" {
  description = "A list of elasticache subnets inside the VPC"
  default     = []
}
