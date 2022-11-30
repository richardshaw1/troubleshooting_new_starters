# =========================================================================================================================
# vpc variables
# =========================================================================================================================
variable "create_vpc" {
  type        = bool
  description = "create a vpc"
  default     = false
}
variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = ""
}
variable "vpc_enable_dns_support" {
  type        = bool
  description = "dns support for vpc"
  default     = false
}
variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "dns hostnames for vpc"
  default     = false
}
# =========================================================================================================================
# resource creation
# =========================================================================================================================
# -------------------------------------------------------------------------------------------------------------------------
# vpc
# -------------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "env_vpc" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = merge(
    local.default_tags,
    {
      "Name" = "${var.owner}-${var.environment}-vpc"
    }
  )
}