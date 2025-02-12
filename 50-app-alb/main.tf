module "alb" {
  source = "terraform-aws-modules/alb/aws"

    internal = true
  #expense-dev-app-alb  
  name    = "${var.project}-${var.environment}-app-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.private_subnet
  create_security_group = false
  security_groups = [local.app_alb_sg_id.value]
  enable_deletion_protection = false

 tags = merge(
    var.common_tags,
    {
        Name = "${var.project}-${var.environment}-app-alb"
    }
 )

}

  # listener
  resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>This is from backend alb<h1>"
      status_code  = "200"
    }
  }
}
  

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "*.app-dev.${var.domain_name}"
  type    = "A"

#these are alb names and zone information
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}