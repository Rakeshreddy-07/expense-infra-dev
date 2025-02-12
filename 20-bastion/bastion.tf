resource "aws_instance" "this" {
  ami                    = data.aws_ami.joindevops.id
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  instance_type          = "t3.micro"
  subnet_id = local.public_subnet_id[0]
  tags = merge(
    var.common_tags,
    var.bastion_tags,
    {
    Name = local.resource_name
  }
  )
}
