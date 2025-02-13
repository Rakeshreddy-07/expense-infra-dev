resource "aws_instance" "backend" {
  ami                    = data.aws_ami.joindevops.id
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  instance_type          = "t3.micro"
  subnet_id = local.private_subnet_id[0]
  tags = merge(
    var.common_tags,
    {
    Name = local.resource_name
  }
  )
}


resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = aws_instance.backend.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.backend.private_ip
    type = "ssh"
    user     = "ec2-user"
    password = "DevOps321"

  }

    provisioner "file" {
        source = "backend.sh"
        destination = "/tmp/backend.sh"
      
    }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +X /tmp/backend.sh",
      "sudo sh /tmp/backend.sh ${var.environment}"
    ]
  }
}