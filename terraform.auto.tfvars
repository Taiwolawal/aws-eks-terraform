region = "eu-east-1"

##############
# VPC Variables
###############
vpc_name        = "eks-vpc"
vpc_cidr        = "10.0.0.0/16"
azs             = ["eu-east-1a", "eu-east-1b"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

database_subnets                   = ["10.0.4.0/24", "10.0.5.0/24"]
create_database_subnet_group       = true
create_database_subnet_route_table = true

enable_nat_gateway = true
single_nat_gateway = true

enable_dns_hostnames = true
enable_dns_support   = true
tags = {
  Terraform   = "true"
  Environment = "dev"
}