locals {
  private_subnet = split(",",data.aws_ssm_parameter.private_subnet_id.value)
  app_alb_sg_id  = data.aws_ssm_parameter.app_alb_sg_id
}