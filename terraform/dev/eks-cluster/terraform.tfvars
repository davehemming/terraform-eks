############# Global #############
aws_region     = "us-east-1"
aws_account_id = "664092492054"
root_domain    = "janesweather.net"
cluster_name   = "jw-tf-sp-dev"
env            = "dev"
repo           = "https://github.com/janesweather/jw-terraform-project-scratchpad.git"

############# VPC #############
cidr = "10.20.0.0/16"
azs  = ["us-east-1a", "us-east-1b", "us-east-1c"]
# IP architecture
public_subnets = [
  "10.20.128.0/24",
  "10.20.129.0/24",
  "10.20.130.0/24"
]
private_subnets = [
  "10.20.192.0/26",
  "10.20.192.64/26",
  "10.20.192.128/26"
]
elasticache_subnets = [
  "10.20.193.0/26",
  "10.20.193.64/26",
  "10.20.193.128/26"
]
