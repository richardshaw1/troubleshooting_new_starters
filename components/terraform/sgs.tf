# =========================================================================================================================
# security group variables
# =========================================================================================================================
variable "sgs" {
  type        = map(any)
  description = "map of security groups"
  default     = {}
}
variable "ec2_sg_description" {
  type        = string
  description = "description for the security groups"
  default     = "security group"
}
variable "inbound_rules_tcp_sp_cidr" {
  type        = map(any)
  description = "map of all rules that are tcp, single port with a cidr range"
  default     = {}
}
variable "egress_all" {
  type        = map(any)
  description = "map of egress all rules"
  default     = {}
}
# =========================================================================================================================
# resource creation
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# security groups
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "ec2_sg" {
  for_each = { for key, value in var.sgs :
    key => value
  if lookup(value, "create_sg", false) == true }
  name        = lookup(each.value, "ec2_sg_name_suffix", "")
  description = lookup(each.value, "ec2_sg_description", "")
  vpc_id      = aws_vpc.env_vpc[0].id
  tags = merge(
    local.default_tags,
    {
      "Name" = lookup(each.value, "ec2_sg_name_suffix", "")
    }
  )
  depends_on = [aws_vpc.env_vpc]
}
# =========================================================================================================================
# rules
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# ingress rules
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_security_group_rule" "ec2_sg_rule_ingress_tcp_sp_cidr" {
  for_each = { for key, value in var.inbound_rules_tcp_sp_cidr :
    key => value
  if lookup(value, "create_rule", false) == true }
  type              = "ingress"
  from_port         = lookup(each.value, "port", "")
  to_port           = lookup(each.value, "port", "")
  protocol          = "tcp"
  cidr_blocks       = lookup(each.value, "cidr_blocks", [])
  security_group_id = aws_security_group.ec2_sg[lookup(each.value, "my_sg", "")].id
  depends_on        = [aws_security_group.ec2_sg]
}
# -------------------------------------------------------------------------------------------------------------------------
# egress rules
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_security_group_rule" "ec2_sg_rule_egress_all" {
  for_each = { for key, value in var.egress_all :
    key => value
  if lookup(value, "create_rule", false) == true }
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg[lookup(each.value, "my_sg", "")].id
  depends_on        = [aws_security_group.ec2_sg]
}