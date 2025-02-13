locals {
  resource_name = "${var.project}-${var.environment}"
  database_subnet_group = data.aws_ssm_parameter.database_subnet_group.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
}