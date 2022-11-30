# =========================================================================================================================
# security group variables
# =========================================================================================================================
sgs = {
  "pw_sg" = {
    "create_sg"          = true
    "ec2_sg_name_suffix" = "prod-web-sg"
    "ec2_sg_description" = "allow traffic from internet"
  }
}
# =========================================================================================================================
# security group rules
# =========================================================================================================================
# #########################################################################################################################
# inbound - tcp, single port, cidr range
# #########################################################################################################################
inbound_rules_tcp_sp_cidr = {
  # -----------------------------------------------------------------------------------------------------------------------
  # ingress tcp_sp_cidr - pw_sg
  # -----------------------------------------------------------------------------------------------------------------------
  "i_pw_sg_22a" = {
    "create_rule" = true
    "port"        = "22"
    "my_sg"       = "pw_sg"
    "cidr_blocks" = ["0.0.0.0/0"]
  }
  "i_pw_sg_80a" = {
    "create_rule" = true
    "port"        = "80"
    "my_sg"       = "pw_sg"
    "cidr_blocks" = ["0.0.0.0/0"]
  }
  "i_pw_sg_443a" = {
    "create_rule" = true
    "port"        = "443"
    "my_sg"       = "pw_sg"
    "cidr_blocks" = ["0.0.0.0/0"]
  }
}
# #########################################################################################################################
# outbound - egress all security groups
# #########################################################################################################################
egress_all = {
  # -----------------------------------------------------------------------------------------------------------------------
  # egress all - pw_sg
  # -----------------------------------------------------------------------------------------------------------------------
  "e_pw_sg_egress_alla" = {
    "create_rule" = true
    "my_sg"       = "pw_sg"
  }
}