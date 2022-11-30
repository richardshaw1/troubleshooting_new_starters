# =========================================================================================================================
# ec2 variables
# =========================================================================================================================
ec2s = {
  "pw_01" = {
    "create_instance"             = true
    "sg_names"                    = ["pw_sg"]
    "ami"                         = "ami-0f540e9f488cfa27d"
    "instance_type"               = "t2.micro"
    "subnet_number"               = "0"
    "associate_public_ip_address" = true
    "user_data"                   = "./templates/user_data/web_bootstrap.sh"
    "tag_name"                    = "prod-web-01"
  }
  "pw_02" = {
    "create_instance"             = true
    "sg_names"                    = ["pw_sg"]
    "ami"                         = "ami-0f540e9f488cfa27d"
    "instance_type"               = "t2.micro"
    "subnet_number"               = "1"
    "associate_public_ip_address" = true
    "user-data"                   = "./templates/user_data/web_bootstrap.sh"
    "tag_name"                    = "prod-web-02"
  }
  "pw_03" = {
    "create_instance"             = true
    "sg_names"                    = ["pw_sg"]
    "ami"                         = "ami-0f540e9f488cfa27d"
    "instance_type"               = "t2.micro"
    "subnet_number"               = "2"
    "associate_public_ip_address" = true
    "userdata"                    = "./templates/user_data/web_bootstrap.sh"
    "tag_name"                    = "prod-web-03"
  }
}