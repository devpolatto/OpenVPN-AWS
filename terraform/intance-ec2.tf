data "aws_ami" "Ubuntu_22" {
  most_recent      = true
  name_regex = "ubuntu"
  owners           = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
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

resource "aws_instance" "instance" {
  ami               = data.aws_ami.Ubuntu_22.id
  instance_type     = "t2.micro"
  availability_zone = "${local.region}a"
  key_name          = aws_key_pair.key_pair.id
#   user_data         = file("")

  network_interface {
    network_interface_id = aws_network_interface.openvpn-network_interface.id
    device_index = 0
  }

  tags                   = merge(var.common_tags, { Name = "OpenVPN" })
}