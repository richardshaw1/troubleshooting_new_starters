# ======================================================================================================================
# application load balancer variables
# ======================================================================================================================
alb = {
  "pw_pub_lb" = {
    "create_alb"   = true
    "alb_name"     = "prod-web-pub-lb"
    "alb_internal" = false
    "alb_type"     = "application"
    "alb_subnets"  = ["0", "1", "2"]
    "alb_sgs"      = ["pw_sg"]
  }
}
alb_listener = {
  "pw_pub_lb_80_f" = {
    "create_alb_listener"  = true
    "alb_resource_name"    = "pw_pub_lb"
    "alb_tg_port"          = "80"
    "alb_tg_protocol"      = "HTP"
    "alb_action"           = "forward"
    "alb_tg_resource_name" = "pw_tg_80"
  }
}
alb_target_group = {
  "pw_tg_80" = {
    "create_alb_tg"   = true
    "alb_tg_name"     = "prod-web-lb-tg-80"
    "alb_tg_port"     = "80"
    "alb_tg_protocol" = "HTTP"
  }
}
alb_targets = {
  "pw_tg_01" = {
    "add_alb_targets"          = true
    "alb_tg_resource_name"     = "pw_tg_80"
    "alb_target_resource_name" = "pw_01"
  }
  "pw_tg_02" = {
    "add_alb_targets"          = true
    "alb_tg_resource_name"     = "pw_tg_80"
    "alb_target_resource_name" = "pw_02"
  }
  "pw_tg_03" = {
    "add_alb_targets"          = true
    "alb_tg_resource_name"     = "pw_tg_80"
    "alb_target_resource_name" = "pw_03"
  }
}