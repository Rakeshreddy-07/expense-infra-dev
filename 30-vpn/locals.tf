locals {
  resource_name = "${var.project}-${var.environment}-vpn"
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_id.value)
}