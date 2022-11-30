# ===================================================================================================================
# ip and cidr variables
# ===================================================================================================================
locals {
  internet_cidr        = "0.0.0.0/0"    # the cidr range for the internet
  vpc_cidr             = "10.0.0.0/16"  # the cidr range for vpc
  pw_pub_subnet_a_cidr = "10.0.0.0/28"  # the cidr range for vpc prod-web-pub-subnet-a
  pw_pub_subnet_b_cidr = "10.0.0.16/28" # the cidr range for vpc prod-web-pub-subnet-b
  pw_pub_subnet_c_cidr = "10.0.0.32/28" # the cidr range for vpc prod-web-pub-subnet-c
}