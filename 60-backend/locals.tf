locals {
  resource_name = "${var.project}-${var.environment}-backend"
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)
}