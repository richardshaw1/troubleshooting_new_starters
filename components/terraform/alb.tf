# ======================================================================================================================
# application load balancer variables
# ======================================================================================================================
variable "alb" {
  type        = map(any)
  description = "application load balancer map"
  default     = {}
}
variable "alb_listener" {
  type        = map(any)
  description = "application load balancer listener map"
  default     = {}
}
variable "alb_target_group" {
  type        = map(any)
  description = "application load balancer target group map"
  default     = {}
}
variable "alb_targets" {
  type        = map(any)
  description = "a map of target instances linked to the application load balancer target group"
  default     = {}
}
# ======================================================================================================================
# resource creation
# ======================================================================================================================
# ----------------------------------------------------------------------------------------------------------------------
# application load balancer
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_lb" "env_alb" {
  for_each = { for key, value in var.alb :
    key => value
  if lookup(value, "create_alb", false) == true }
  name               = lookup(each.value, "alb_name", "")
  internal           = lookup(each.value, "alb_internal", "")
  load_balancer_type = lookup(each.value, "alb_type", "")
  subnet_id          = [for sn in lookup(each.value, "alb_subnets", []) : aws_subnet.env_subnet[sn].id]
  security_groups    = [for sg in lookup(each.value, "alb_sgs", []) : aws_security_group.ec2_sg[sg].id]
  tags = merge(
    local.default_tags,
    {
      "Name" = lookup(each.value, "alb_name", "")
    },
  )
}
# ----------------------------------------------------------------------------------------------------------------------
# application load balancer listener
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_lb_listener" "env_alb_listener" {
  for_each = { for key, value in var.alb_listener :
    key => value
  if lookup(value, "create_alb_listener", false) == true }
  load_balancer_arn = aws_lb.env_alb[lookup(each.value, "alb_resource_name", "")].arn
  port              = lookup(each.value, "alb_tg_port", "")
  protocol          = lookup(each.value, "alb_tg_protocol", "")
  default_action {
    type             = lookup(each.value, "alb_action", "")
    target_group_arn = aws_lb_target_group.env_alb_target_group[lookup(each.value, "alb_tg_resource_name", "")].arn
  }
  depends_on = [aws_lb_target_group.env_alb_target_group]
}
# ----------------------------------------------------------------------------------------------------------------------
# application load balancer target group
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_lb_target_group" "env_alb_target_group" {
  for_each = { for key, value in var.alb_target_group :
    key => value
  if lookup(value, "create_alb_tg", false) == true }
  name        = lookup(each.value, "alb_tg_name", "")
  port        = lookup(each.value, "alb_tg_port", "")
  protocol    = lookup(each.value, "alb_tg_protocol", "")
  vpc_id      = aws_vpc.env_vpc[0].id
  depends_on = [aws_lb.env_alb]
}
# ----------------------------------------------------------------------------------------------------------------------
# application load balancer targets
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_lb_target_group_attachment" "env_alb_target_group_attach" {
  for_each = { for key, value in var.alb_targets :
    key => value
  if lookup(value, "add_alb_targets", false) == true }
  target_group_arn = aws_lb_target_group.env_alb_target_group[lookup(each.value, "alb_tg_resource_name", "")].arn
  target_id        = aws_instance.env_instance[lookup(each.value, "alb_target_resource_name", "")].id
  depends_on       = [aws_instance.env_instance]
}