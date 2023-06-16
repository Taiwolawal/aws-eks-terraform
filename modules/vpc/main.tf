module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  # VPC Basic Details
  name = var.vpc_name
  cidr = var.cidr
  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # Database Subnets
  database_subnets = var.database_subnets
  create_database_subnet_group = var.create_database_subnet_group
  create_database_subnet_route_table = var.create_database_subnet_route_table

  # VPC DNS Parameters
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

    # VPC DNS Parameters
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.tags
}