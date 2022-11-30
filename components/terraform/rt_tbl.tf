# =========================================================================================================================
# route table variables
# =========================================================================================================================
variable "create_rtbl" {
  type        = bool
  description = "creates route table"
  default     = false
}
variable "create_route" {
  type        = bool
  description = "creates route"
  default     = false
}
variable "public_subnets" {
  type        = list(any)
  description = "a list of subnets for public routes"
  default     = []
}
# =========================================================================================================================
# resource creation
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# rt_tbl
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "env_rt_tbl" {
  count  = (var.create_rtbl ? 1 : 0) * length(var.subnet_names)
  vpc_id = aws_vpc.env_vpc[0].id
  tags = merge(
    local.default_tags,
    {
      "Name" = "${var.subnet_names[count.index]}-rt_tbl"
    },
  )
  depends_on = [aws_subnet.env_subnet]
}
# -------------------------------------------------------------------------------------------------------------------------
# rt_tbl_association
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_route_table_association" "env_rt_tbl_assoc" {
  count          = (var.create_rtbl ? 1 : 0) * length(keys(var.subnet_names))
  subnet_id      = aws_subnet.env_subnet[count.index].id
  route_table_id = element(aws_route_table.env_rt_tbl.*.id, count.index)
  depends_on     = [aws_subnet.env_subnet]
}
# =========================================================================================================================
# routes
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# route: public route to internet
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_route" "pub_sub_to_internet" {
  count                  = (var.create_rtbl ? 1 : 0) * length(var.public_subnets)
  route_table_id         = element(aws_route_table.env_rt_tbl.*.id, element(var.public_subnets, count.index))
  destination_cidr_block = local.internet_cidr
  gateway_id             = aws_internet_gateway.env_igw[0].id
  depends_on             = [aws_internet_gateway.env_igw]
}