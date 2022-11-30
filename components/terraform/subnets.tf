# =========================================================================================================================
# subnet variables
# =========================================================================================================================
variable "create_subnets" {
  type        = bool
  description = "create vpc subnets"
  default     = false
}
variable "map_public_ip_on_launch" {
  type        = bool
  description = "maps public ip on launch"
  default     = false
}
variable "subnet_names" {
  type        = map(any)
  description = "map of subnet names"
  default     = {}
}
variable "subnet_cidrs" {
  type        = map(any)
  description = "map of subnet cidr ranges"
  default     = {}
}
# =========================================================================================================================
# resource creation
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# subnets
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "env_subnet" {
  count                   = (var.create_subnets ? 1 : 0) * length(var.environment_azs)
  vpc_id                  = aws_vpc.env_vpc[0].id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = "${var.region}${var.environment_azs[count.index]}"
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(
    local.default_tags,
    {
      "Name" = var.subnet_names[count.index]
    }
  )
  depends_on = [aws_vpc.env_vpc]
}