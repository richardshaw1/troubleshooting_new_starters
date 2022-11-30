terraform {
  backend "s3" {
    bucket = "${var.owner}-terraform-backend-state-${var.region}-${var.aws_account}"
    key    = "${var.environment}/${var.environment}.tfstate"
    region = var.region
  }
}