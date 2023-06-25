variable "vpc_name" {
  type    = string
  default = "Demo-vpc"
}

variable "cidr" {
  type    = string
  default = ""
}

# variable "vpc_id" {
#   type    = string
# }

variable "region" {
  type    = string
}

variable "private_subnets" {
  type    = list(any)
  default = []
}

variable "public_subnets" {
  type    = list(any)
  default = []
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