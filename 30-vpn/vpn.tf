
resource "aws_key_pair" "openvpnas" {
  key_name   = "openvpnas"
  public_key = file("D:\\DevOps\\openvpnas.pub")
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.openvpn.id
  key_name = aws_key_pair.openvpnas.key_name
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  instance_type          = "t3.micro"
  subnet_id = local.public_subnet_id[0]
  user_data = file("user-data.sh")
  tags = merge(
    var.common_tags,
    var.bastion_tags,
    {
    Name = local.resource_name
  }
  )
}

output "vpn_ip" {

  value = aws_instance.this.public_ip
}