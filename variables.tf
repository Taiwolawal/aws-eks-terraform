variable "region" {
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "Demo-vpc"
}

variable "cidr" {
  type    = string
  default = ""
}

variable "azs" {
  type    = list(any)
  default = []
}

variable "private_subnets" {
  type    = list(any)
  default = []
}

variable "public_subnets" {
  type    = list(any)
  default = []
}

variable "database_subnets" {
  type    = list(any)
  default = []
}

variable "create_database_subnet_group" {
  type    = bool
}

variable "create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type = bool
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type = bool
}

variable "single_nat_gateway" {
  type    = bool
}

variable "enable_dns_hostnames" {
  type    = bool
}

variable "enable_dns_support" {
  type    = bool
}

variable "tags" {
  type    = map(any)
  default = {}
}