# ======================================================================================================================
# global variables
# ======================================================================================================================
variable "aws_account" {
  type        = string
  description = "aws account id"
  default     = ""
}
variable "region" {
  type        = string
  description = "aws region"
  default     = "eu-west-2"
}
variable "environment_azs" {
  type        = map(any)
  description = "map list of the number of availability zones to use and which character to use for the suffix e.g eu-west-2a, eu-west-2b, eu-west-2c"
  default = {
    "0" = "a"
    "1" = "b"
    "2" = "c"
  }
}
variable "client_abbr" {
  type        = string
  description = "abbreviated name of the client e.g "
  default     = ""
}
variable "environment" {
  type        = string
  description = "name of the environment the resource is deployed to, e.g. troubleshooting, etc"
  default     = "troubleshooting"
}
variable "owner" {
  type        = string
  description = "the owner of the environment e.g "
  default     = ""
}
# -------------------------------------------------------------------------------------------------------------------
# locally defined variables
# -------------------------------------------------------------------------------------------------------------------
locals {
  # -------------------------------------------------------------------------------------------------------------------
  # Standard Tags for AWS Resources
  # -------------------------------------------------------------------------------------------------------------------
  default_tags = {
    Owner = var.owner
  }
  default_list_tags = [
    {
      "key"   = "Owner"
      "value" = var.owner
    }
  ]
}