module "alb" {
  source = "terraform-aws-modules/alb/aws"

    internal = false
  #expense-dev-app-alb  
  name    = "${var.project}-${var.environment}-web-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.public_subnet
  create_security_group = false
  security_groups = [local.web_alb_sg_id.value]
  enable_deletion_protection = false

 tags = merge(
    var.common_tags,
    {
        Name = "${var.project}-${var.environment}-web-alb"
    }
 )

}


resource "aws_lb_listener" "web_alb_listener" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.web_alb_cert_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>This is from forntend web alb with https<h1>"
      status_code  = "200"
    }
  }
}


resource "aws_route53_record" "web_alb" {
  zone_id = var.zone_id
  name    = "expense-${var.environment}.${var.domain_name}"
  type    = "A"

#these are alb names and zone information
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}