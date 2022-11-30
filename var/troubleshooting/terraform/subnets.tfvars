# =========================================================================================================================
# subnet variables
# =========================================================================================================================
create_subnets          = true
map_public_ip_on_launch = true
subnet_names = {
  # public subnets
  "0" = "prod-web-pub-subnet-a"
  "1" = "prod-web-pub-subnet-b"
  "2" = "prod-web-pub-subnet-c"
}
environment_azs = {
  # public subnets
  "0" = "a"
  "1" = "b"
  "2" = "c"
}
subnet_cidrs = {
  # public subnets
  "0" = "10.0.0.0/28"
  "1" = "10.0.0.16/28"
  "2" = "10.0.0.32/28"
}