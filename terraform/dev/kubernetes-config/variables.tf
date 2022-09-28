variable "aws_account_id" {
  description = "The id of the one AWS account this code is permitted to run against"
  type        = string
}

variable "aws_region" {
  default     = "ap-southeast-2"
  description = "Asia Pacific (Sydney) Region"
  type        = string
}

variable "root_domain" {
  description = "The Root Domain Name e.g. janesweather.net"
  type        = string
}

variable "env" {
  description = "Environment that is used as placeholder"
  default     = ""
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

variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
}
