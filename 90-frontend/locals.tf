locals {
  resource_name = "${var.project}-${var.environment}-frontend"
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_id.value)
  public_subnet_ids = split(",",data.aws_ssm_parameter.public_subnet_id.value)
  frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}