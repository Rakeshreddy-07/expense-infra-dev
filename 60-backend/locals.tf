locals {
  resource_name = "${var.project}-${var.environment}-backend"
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)
  private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_id.value)
  backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}