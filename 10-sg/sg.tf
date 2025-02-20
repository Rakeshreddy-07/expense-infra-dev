module "mysql_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for mysql"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "mysql"
}

module "backend_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for backend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "backend"
}

module "frontend_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for frontend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "frontend"
}

module "bastion_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for bastion"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "bastion"
}

module "app_alb_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for app alb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "app_alb"
}

module "web_alb_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for web alb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "web_alb"
}


#VPN SG #ports 22,443,1194,943
module "vpn_sg" {
    source = "git::https://github.com/Rakeshreddy-07/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    common_tags = var.common_tags
    sg_tags = var.sg_tags
    description = "created for vpn"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "vpn"
}

#add SG rul in app alb SG 
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

#add inbound rule to bastion SG
resource "aws_security_group_rule" "bastion_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

#add inbound rule to vpn
resource "aws_security_group_rule" "vpn_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}


resource "aws_security_group_rule" "vpn_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "mysql_vpn" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "backend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}

resource "aws_security_group_rule" "backend_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.backend_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "backend_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}

resource "aws_security_group_rule" "alb_backend_allow" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id       = module.app_alb_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}

resource "aws_security_group_rule" "web_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.sg_id
}

resource "aws_security_group_rule" "frontend_allow_web_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.web_alb_sg.sg_id
  security_group_id = module.frontend_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_allow_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.frontend_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

#usually we should configure frontend using private ip only
resource "aws_security_group_rule" "forntend_public_allow" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend_sg.sg_id
}