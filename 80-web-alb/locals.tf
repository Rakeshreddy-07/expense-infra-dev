locals {
  public_subnet = split(",",data.aws_ssm_parameter.public_subnet_id.value)
  web_alb_sg_id  = data.aws_ssm_parameter.web_alb_sg_id
  web_alb_cert_arn = data.aws_ssm_parameter.web_alb_cert_arn.value
}