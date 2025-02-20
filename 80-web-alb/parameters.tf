resource "aws_ssm_parameter" "web_alb_listener" {
  name  = "/${var.project}/${var.environment}/web_alb_listener"
  type  = "String"
  value = aws_lb_listener.web_alb_listener.arn
}