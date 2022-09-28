variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "admin_users" {
  description = "Kubernetes Admin Users"
  type        = list(string)
  default     = []
}

variable "developer_users" {
  description = "Kubernetes Admin Users"
  type        = list(string)
  default     = []
}
