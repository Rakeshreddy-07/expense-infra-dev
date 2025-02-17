data "aws_ami" "joindevops" {
  owners      = [973714476881]
  most_recent = true
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]

  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project}/${var.environment}/backend_sg_id"
}


data "aws_ssm_parameter" "private_subnet_id" {
  name = "/${var.project}/${var.environment}/private_subnet_id"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "app_alb_listener_arn" {
  name = "/${var.project}/${var.environment}/app_alb_listener_arn"
}