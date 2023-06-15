variable "region" {
  default = "us-east-1"
}

variable "name" {
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

variable "create_database_subnet_group" {
  type    = bool
  default = false
}

variable "database_subnets" {
  type    = list(any)
  default = []
}

variable "database_subnet_group_name" {
  type    = string
  default = "demo-db-subnet"
}

variable "manage_default_route_table" {
  type    = bool
  default = true
}

variable "default_route_table_tags" {
  type    = map(any)
  default = {}
}

variable "manage_default_security_group" {
  type    = bool
  default = true
}

variable "default_security_group_tags" {
  type    = map(any)
  default = {}
}

variable "enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_classiclink_dns_support" {
  type    = bool
  default = false
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(any)
  default = {}
}