# =========================================================================================================================
# ec2 variables
# =========================================================================================================================
variable "ec2s" {
  type        = map(any)
  description = "ec2 instances map"
  default     = {}
}
# =========================================================================================================================
# resource creation
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# ec2s
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "env_instance" {
  for_each = { for key, value in var.ec2s :
    key => value
  if lookup(value, "create_instance", false) == true }
  vpc_security_group_ids      = [for sg in lookup(each.value, "sg_names", []) : aws_security_group.ec2_sg[sg].id]
  ami                         = lookup(each.value, "ami", "")
  instance_type               = lookup(each.value, "instance_type", "")
  subnet                      = element(aws_subnet.env_subnet.*.id, lookup(each.value, "subnet_number", ""))
  associate_public_ip_address = lookup(each.value, "associate_public_ip_address", false)
  user_data                   = templatefile("${path.module}/${lookup(each.value, "user_data", "")}", {})
  tags = merge(
    local.default_tags,
    {
      "Name" = lookup(each.value, "tag_name", "")
    },
  )
  volume_tags = merge(
    local.default_tags,
    {
      "Name" = lookup(each.value, "tag_name", "")
    }
  )
}