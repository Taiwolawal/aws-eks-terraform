module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  for_each = var.security_groups

  name        = lookup(each.value, "name", "")
  description = lookup(each.value, "description", "")
  vpc_id      = lookup(each.value, "vpc_id", module.vpc.vpc_id)
  create      = lookup(each.value, "create", false)

  # ID of existing security group whose rules we will manage
  security_group_id = lookup(each.value, "security_group_id", "")

  # Map of known security group rules https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/4.9.0#input_rules
  ingress_with_cidr_blocks = lookup(each.value, "ingress_with_cidr_blocks", [])
  egress_with_cidr_blocks  = lookup(each.value, "egress_with_cidr_blocks", [])
  ingress_rules            = lookup(each.value, "ingress_rules", [])
  egress_cidr_blocks       = lookup(each.value, "egress_cidr_blocks", [])
  egress_rules             = lookup(each.value, "egress_rules", [])
}