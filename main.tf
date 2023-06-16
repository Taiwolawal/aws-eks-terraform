module "VPC" {
    source = "./modules/vpc"
    cidr = var.cidr
    region = var.region
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets
    database_subnets = var.database_subnets
    create_database_subnet_group = var.create_database_subnet_group
    create_database_subnet_route_table = var.create_database_subnet_route_table
    enable_nat_gateway = var.enable_nat_gateway
    single_nat_gateway = var.single_nat_gateway
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support
    tags = var.tags
}

# module "EKS" {
  
# }