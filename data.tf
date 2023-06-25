data "aws_caller_identity" "current" {}

data "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  filter {
    name   = "tag:Name"
    values = ["Demo-vpc"]
  }
}